variable "default_tags" {
  description = "(Required) Default tag for AWS resource"
  default = {
    env         = "dev"
    project     = "github-runner-batch"
    github_repo = ""
    component   = "main"
  }
}