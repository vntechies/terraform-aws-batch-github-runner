variable "default_tags" {
  description = "(Required) Default tag for AWS resource"
  default = {
    env         = "dev"
    project     = "terraform-aws-batch-github-runner"
    github_repo = ""
    component   = "batch"
  }
}
variable "batch_compute_env" {
  description = "Specifies the set of compute environments mapped to a job queue and their order"
  type = any
}
variable "batch_job_definition" {
  description = "Specifies the set of batch job definition resources"
  type = any
}
variable "batch_name_prefix" {
  description = "A prefix of all batch resources name. Default is aws-batch"
  type    = string
  default = "aws-batch"
}
variable "compute_security_group" {
  description = "A list of EC2 security group that are associated with instances launched in the compute environment"
  type = list(any)
}
variable "compute_subnet_ids" {
  description = "A list of VPC subnets into which the compute resources are launched."
  type = list(any)
}
variable "compute_service_role" {
  description = "The full Amazon Resource Name (ARN) of the IAM role that allows AWS Batch to make calls to other AWS services on your behalf"
  type = string
}

