# aws-batch-github-actions-runner
AWS Batch for self hosted GitHub action runners
![AWS Batch Github Runner](/assets/aws-batch-gh-runner-diagram.PNG "AWS Batch Github Runner Diagram")
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | ./modules/api-gateway | n/a |
| <a name="module_batch"></a> [batch](#module\_batch) | ./modules/batch | n/a |
| <a name="module_iam_role"></a> [iam\_role](#module\_iam\_role) | ./modules/iam | n/a |
| <a name="module_networks"></a> [networks](#module\_networks) | ./modules/networks | n/a |
| <a name="module_secrets_manager"></a> [secrets\_manager](#module\_secrets\_manager) | ./modules/secrets-manager | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | (Required) Default tag for AWS resource | `map` | <pre>{<br>  "component": "main",<br>  "env": "dev",<br>  "github_repo": "",<br>  "project": "github-runner-batch"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_invoke_url"></a> [api\_gateway\_invoke\_url](#output\_api\_gateway\_invoke\_url) | n/a |
| <a name="output_batch_job_definition"></a> [batch\_job\_definition](#output\_batch\_job\_definition) | n/a |
| <a name="output_ec2_batch_job_queue"></a> [ec2\_batch\_job\_queue](#output\_ec2\_batch\_job\_queue) | n/a |
| <a name="output_fargate_batch_job_queue"></a> [fargate\_batch\_job\_queue](#output\_fargate\_batch\_job\_queue) | n/a |
| <a name="output_secret_app_key"></a> [secret\_app\_key](#output\_secret\_app\_key) | n/a |
<!-- END_TF_DOCS -->
