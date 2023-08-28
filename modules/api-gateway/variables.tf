variable "default_tags" {
  description = "(Required) Default tag for AWS resource"
  default = {
    env         = "dev"
    project     = "terraform-aws-batch-github-runner"
    github_repo = ""
    component   = "api-gateway"
  }
}

variable "apigw_excution_role_arn" {
  description = "Credentials required for the integration"
  type = string
}
variable "model_json_schema" {
  description = "Schema of the model in a JSON form"
  type = any
}
variable "integration_mapping_model" {
  description = "Map of the integration's request templates"
  type = string
}
variable "region" {
  description = "Region that API Gateway will deploy"
  type = string
}
variable "api_gateway_stage_name" {
  description = "Name of the stage"
  type = string
}
variable "api_gateway_path" {
  description = "Last path segment of this API resource."
  type = string
}
