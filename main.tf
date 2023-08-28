provider "aws" {
  region = local.region
  default_tags {
    tags = var.default_tags
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  region       = "ap-southeast-1"
  org_id       = "tnx-journey-to-cloud"
  org_user_ids = ["kerashanog", "hungran", "dtanhv1704", "haicasgox", "HieuChayA4", "hiimtung", "lacoski", "lqanh10", "huulc"]

  # Container Setup
  github_app_id         = "245738"
  secret_gh_private_key = module.secrets_manager.secret_arn
  iam_excutionrole_arn  = module.iam_role.batch_job_excution_role_arn
  runner_image          = "myoung34/github-runner:latest"

  # VPC Setup
  cidr_block     = "10.1.0.0/16"
  azs            = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]

  # Batch Compute Environment
  batch_compute_env = {
    ec2-env = {
      allocation_strategy = "BEST_FIT_PROGRESSIVE",
      desired_vcpus       = 0,
      instance_type       = ["optimal"],
      instance_role       = module.iam_role.batch_instance_role_arn,
      max_vcpus           = 10,
      min_vcpus           = 0,
      type                = "EC2",
    },
    fargate-env = {
      max_vcpus = 10,
      type      = "FARGATE"
    }
  }

  # Batch Container Properties
  fargate_container_properties = {
    container_image       = local.runner_image
    container_vcpus       = "0.25"
    container_memory      = "512"
    gh_app_id             = local.github_app_id
    secret_gh_private_key = local.secret_gh_private_key
    iam_excutionrole_arn  = local.iam_excutionrole_arn
  }
  ec2_container_properties = {
    container_image       = local.runner_image
    container_vcpus       = "1"
    container_memory      = "1024"
    gh_app_id             = local.github_app_id
    secret_gh_private_key = local.secret_gh_private_key
    iam_excutionrole_arn  = local.iam_excutionrole_arn
  }
  batch_jobs = {
    fargate-batch-job-queue  = "${module.batch.fargate_batch_job_queue}"
    ec2-batch-job-queue      = "${module.batch.ec2_batch_job_queue}"
    fargate-batch-job-define = "${module.batch.batch_job_definition.fargate}"
    ec2-batch-job-define     = "${module.batch.batch_job_definition.ec2}"
  }
  organization = {
    org_id       = local.org_id
    org_user_ids = local.org_user_ids
  }
}

resource "random_string" "random" {
  length  = 5
  special = false
}

module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  version                 = "5.1.0"
  name                    = "aws-batch-github-runner"
  cidr                    = local.cidr_block
  azs                     = local.azs
  public_subnets          = local.public_subnets
  map_public_ip_on_launch = true
  enable_dhcp_options     = true
  enable_dns_hostnames    = true
  enable_dns_support      = true

}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "batch-jobs-sg"
  description = "Security group for Batch Jobs"
  vpc_id      = module.vpc.vpc_id

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  depends_on = [
    module.vpc
  ]
}

module "batch" {
  source = "./modules/batch"

  batch_name_prefix = random_string.random.result

  # Batch Compute Environment
  batch_compute_env      = local.batch_compute_env
  compute_security_group = [module.security_group.security_group_id]
  compute_subnet_ids     = module.vpc.public_subnets
  compute_service_role   = module.iam_role.batch_service_role_arn

  ## Batch Job Definition ##
  batch_job_definition = {
    ec2 = {
      platform_capabilities = "EC2"
      timeout               = 300 # is 5 minutes
      container_properties  = templatefile("./configs/ec2_job_definition.tftpl", local.ec2_container_properties)
    },
    fargate = {
      platform_capabilities = "FARGATE"
      timeout               = 180 # is 3 minutes
      container_properties  = templatefile("./configs/fargate_job_definition.tftpl", local.fargate_container_properties)
    }
  }
}

module "secrets_manager" {
  source                  = "./modules/secrets-manager"
  secret_name             = "github/org/app-private-key"
  secret_values           = "./configs/app.pem"
  recovery_window_in_days = 0 # Default value is 0
}
module "iam_role" {
  source              = "./modules/iam"
  secret_resource_arn = module.secrets_manager.secret_arn
}

module "api_gateway" {
  source                    = "./modules/api-gateway"
  region                    = local.region
  api_gateway_path          = "webhook"
  api_gateway_stage_name    = "v1"
  apigw_excution_role_arn   = module.iam_role.api_gateway_excution_role_arn
  model_json_schema         = templatefile("./configs/model_github_schema.tftpl", local.organization)
  integration_mapping_model = templatefile("./configs/integrate_mapping_model_batch_job.tftpl", local.batch_jobs)
}
