variable "default_tags" {
  description = "(Required) Default tag for AWS resource"
  default = {
    env         = "dev"
    project     = "github-runner-batch"
    github_repo = ""
    component   = "api-gateway"
  }
}

variable "apigw_excution_role_arn" {
  type = string
}
variable "model_json_schema" {
  type = any
}
variable "integration_mapping_model" {
  type = string  
}