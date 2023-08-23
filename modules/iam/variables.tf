variable "default_tags" {
  description = "(Required) Default tag for AWS resource"
  default = {
    env         = "dev"
    project     = "github-runner-batch"
    github_repo = ""
    component   = "iam-roles"
  }
}

variable "secret_resource_arn" {
  type = string
}
