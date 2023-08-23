variable "default_tags" {
  description = "(Required) Default tag for AWS resource"
  default = {
    env         = "dev"
    project     = "github-runner-batch"
    github_repo = ""
    component   = "secrets-manager"
  }
}
variable "secret_values" {
  type = string
  default = ""
}