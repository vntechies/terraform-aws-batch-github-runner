###################  New AWS Batch Compute Env ################### 
resource "aws_batch_compute_environment" "this" {
  for_each = var.batch_compute_env
  compute_environment_name = "${each.key}-${var.batch_name_prefix}"

  compute_resources {
    allocation_strategy = try(each.value.allocation_strategy, null)
    bid_percentage = try(each.value.bid_percentage, null)
    desired_vcpus = try(each.value.desired_vcpus, null)
    instance_role = try(each.value.instance_role, null)
    instance_type = try(each.value.instance_type, null)

    max_vcpus = try(each.value.max_vcpus, 10)
    min_vcpus = try(each.value.min_vcpus, null)
    
    security_group_ids = var.compute_security_group
    subnets = var.compute_subnet_ids
    type = try(each.value.type, "FARGATE_SPOT")
  }

  service_role = var.compute_service_role
  type = "MANAGED"
  lifecycle {
    create_before_destroy = true
  }
  tags = var.default_tags
  depends_on = [
    var.compute_security_group,
    var.compute_subnet_ids,
    var.compute_service_role,
    var.batch_compute_env
  ]

}
################### New Batch Job Definition ###################
resource "aws_batch_job_definition" "self_hosted_runner" {
  for_each = var.batch_job_definition
  name = "${each.key}-github-runner-${var.batch_name_prefix}"
  type = "container"
  platform_capabilities = [each.value.platform_capabilities]
  propagate_tags = true
  timeout {
    attempt_duration_seconds = each.value.timeout
  }
  container_properties = each.value.container_properties
  lifecycle {
    create_before_destroy = true
  }
  tags = var.default_tags
  depends_on = [
    var.batch_job_definition,
    aws_batch_compute_environment.this
  ]
}
################################################################
locals {
  ec2_env = [ for k, v in var.batch_compute_env : aws_batch_compute_environment.this[k].arn if contains(["EC2", "SPOT"], v.type) ]
  fargate_env = [ for k, v in var.batch_compute_env : aws_batch_compute_environment.this[k].arn if contains(["FARGATE", "FARGATE_SPOT"], v.type) ]
}
################### New Batch Queue ###################
resource "aws_batch_job_queue" "ec2" {
  count = length(local.ec2_env) > 0 ? 1 : 0
  name = "ec2-batch-queue-${var.batch_name_prefix}"
  state = "ENABLED"
  priority = 1
  compute_environments = local.ec2_env
  tags = var.default_tags
  depends_on = [
    aws_batch_compute_environment.this,
    local.ec2_env
  ]
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_batch_job_queue" "fargate" {
  count = length(local.fargate_env) > 0 ? 1 : 0
  name = "fargate-batch-queue-${var.batch_name_prefix}"
  state = "ENABLED"
  priority = 1
  compute_environments = local.fargate_env
  tags = var.default_tags
  depends_on = [
    aws_batch_compute_environment.this,
    local.fargate_env
  ]
  lifecycle {
    create_before_destroy = true
  }
}