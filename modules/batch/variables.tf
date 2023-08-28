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
  type = any 
}
variable "batch_job_definition" {
  type = any
}
variable "batch_name_prefix" {
  type = string
  default = "aws-batch"
}
variable "compute_security_group" {
  type = list
}
variable "compute_subnet_ids" {
  type = list
}
variable "compute_service_role" {
  type = string
}

