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
  description = "GitHub App Private Key value"
  type    = string
  default = ""
}

variable "secret_name" {
  description = "Friendly name of GitHub App Private Key"
  type = string
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 0"
  type    = number
  default = 0
}
