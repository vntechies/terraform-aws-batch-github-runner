<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_deployment.deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_integration.api_to_batch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration_response.batch_response_apigw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration_response) | resource |
| [aws_api_gateway_method.post](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method_response.response](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_response) | resource |
| [aws_api_gateway_model.github_webhook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_model) | resource |
| [aws_api_gateway_request_validator.validate_request](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_request_validator) | resource |
| [aws_api_gateway_resource.webhook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_rest_api.github_batch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_stage.stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apigw_excution_role_arn"></a> [apigw\_excution\_role\_arn](#input\_apigw\_excution\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | (Required) Default tag for AWS resource | `map` | <pre>{<br>  "component": "api-gateway",<br>  "env": "dev",<br>  "github_repo": "",<br>  "project": "github-runner-batch"<br>}</pre> | no |
| <a name="input_integration_mapping_model"></a> [integration\_mapping\_model](#input\_integration\_mapping\_model) | n/a | `string` | n/a | yes |
| <a name="input_model_json_schema"></a> [model\_json\_schema](#input\_model\_json\_schema) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_invoke_url"></a> [api\_invoke\_url](#output\_api\_invoke\_url) | n/a |
<!-- END_TF_DOCS -->