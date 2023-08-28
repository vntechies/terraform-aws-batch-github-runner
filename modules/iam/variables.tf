variable "default_tags" {
  description = "(Required) Default tag for AWS resource"
  default = {
    env         = "dev"
    project     = "terraform-aws-batch-github-runner"
    github_repo = ""
    component   = "iam-roles"
  }
}

variable "secret_resource_arn" {
  description = "ARN of GitHub App Private Key stored in Secret Manager"
  type = string
}
