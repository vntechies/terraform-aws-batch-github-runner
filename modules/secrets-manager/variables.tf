variable "default_tags" {
  description = "(Required) Default tag for AWS resource"
  default = {
    env         = "dev"
    project     = "terraform-aws-batch-github-runner"
    github_repo = ""
    component   = "secrets-manager"
  }
}
variable "secret_values" {
  type = string
  default = ""
}

variable "secret_name" {
  type = string
}

variable "recovery_window_in_days" {
  type = number
  default = 0
}