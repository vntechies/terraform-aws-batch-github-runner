resource "random_string" "random" {
  length = 5
  special = false
}

locals {
  batch_compute_env = {
    ec2-env = {
      allocation_strategy = "BEST_FIT_PROGRESSIVE",
      desired_vcpus = 0,
      instance_type = ["optimal"],
      instance_role = module.iam_role.batch_instance_role_arn,
      max_vcpus = 10,
      min_vcpus = 0,
      type = "EC2",
    },
    fargate-env = {
      max_vcpus = 10,
      type = "FARGATE"
    }
  }
  fargate_container_properties = {
    # container_image = "266198327553.dkr.ecr.ap-southeast-1.amazonaws.com/keras-runner:v2.0"
    container_image = "myoung34/github-runner:latest"
    container_vcpus = "0.25"
    container_memory = "512"
    gh_app_id = "245738" 
    secret_gh_private_key = "${module.secrets_manager.secret_arn}"
    iam_excutionrole_arn = "${module.iam_role.batch_job_excution_role_arn}"
  }
  ec2_container_properties = {
    # container_image = "266198327553.dkr.ecr.ap-southeast-1.amazonaws.com/keras-runner:v2.0"
    container_image = "myoung34/github-runner:latest"
    container_vcpus = "1"
    container_memory = "1024"
    gh_app_id = "245738" 
    secret_gh_private_key = "${module.secrets_manager.secret_arn}"
    iam_excutionrole_arn = "${module.iam_role.batch_job_excution_role_arn}"
  }
}
module "batch" {
  source = "./modules/batch"

  batch_name_prefix = "${random_string.random.result}"

  # Batch Compute Environment
  batch_compute_env = local.batch_compute_env
  compute_security_group = [module.networks.security_group]
  compute_subnet_ids = module.networks.subnet_ids
  compute_service_role = module.iam_role.batch_service_role_arn

  ## Batch Job Definition ##
  batch_job_definition = {
    ec2 = {
      platform_capabilities = "EC2"
      timeout = 300 # is 5 minutes
      container_properties = templatefile("./configs/ec2_job_definition.tftpl", local.ec2_container_properties)
    },
    fargate = {
      platform_capabilities = "FARGATE"
      timeout = 180 # is 3 minutes
      container_properties = templatefile("./configs/fargate_job_definition.tftpl", local.fargate_container_properties)
    }
  }
}

module "networks" {
  source = "./modules/networks"
}
module "secrets_manager" {
  source = "./modules/secrets-manager"  
  secret_values = "./configs/app.pem"
}
module "iam_role" {
  source = "./modules/iam"
  secret_resource_arn = module.secrets_manager.secret_arn
}
locals {
  batch_jobs = {
    fargate-batch-job-queue = "${module.batch.fargate_batch_job_queue}"
    ec2-batch-job-queue = "${module.batch.ec2_batch_job_queue}"
    fargate-batch-job-define = "${module.batch.batch_job_definition.fargate}"
    ec2-batch-job-define = "${module.batch.batch_job_definition.ec2}"
  }
  organization = {
    org-user-ids = [ "kerashanog", "hungran", "dtanhv1704", "haicasgox", "HieuChayA4", "hiimtung", "lacoski", "lqanh10", "huulc" ]
  }  
}
module "api_gateway" {
  source = "./modules/api-gateway"
  apigw_excution_role_arn = module.iam_role.api_gateway_excution_role_arn
  model_json_schema = templatefile("./configs/new_github_schema.tftpl", local.organization)
  integration_mapping_model = templatefile("./configs/new_batch_job.tftpl", local.batch_jobs)
}
