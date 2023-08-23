module "vpc" {
  source  = "app.terraform.io/tnx-journey-to-cloud/vpc/aws"
  version = "1.1.7"

  for_each = var.vpc

  vpc_name       = each.key
  vpc_cidr_block = each.value.vpc_cidr_block
  subnets        = each.value.subnets
  prefix         = local.app_env_prefix
  endpoints      = try(each.value.endpoints, [])
  route_table_setting = try(each.value.route_table_setting, {})
  igw_config = try(each.value.igw_config,{})
}

module "security_group" {
  source   = "terraform-aws-modules/security-group/aws"
  version  = "4.9.0"

  name        = "batch-jobs-sg"
  description = "Security group for Batch Jobs"
  vpc_id      = module.vpc["github-runner-batch"].vpc_id
  
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  depends_on = [
    module.vpc
  ]
}