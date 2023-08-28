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
| [aws_iam_instance_profile.ecs_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.api_gateway_excution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.batch_compute_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.job_def_excution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy.batch_service_link_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.ecs_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.ecs_task_excution_role_managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.apigw_submit_batch_jobs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_secret_resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | (Required) Default tag for AWS resource | `map` | <pre>{<br>  "component": "iam-roles",<br>  "env": "dev",<br>  "github_repo": "",<br>  "project": "terraform-aws-batch-github-runner"<br>}</pre> | no |
| <a name="input_secret_resource_arn"></a> [secret\_resource\_arn](#input\_secret\_resource\_arn) | ARN of GitHub App Private Key stored in Secret Manager | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_excution_role_arn"></a> [api\_gateway\_excution\_role\_arn](#output\_api\_gateway\_excution\_role\_arn) | n/a |
| <a name="output_batch_instance_role_arn"></a> [batch\_instance\_role\_arn](#output\_batch\_instance\_role\_arn) | n/a |
| <a name="output_batch_job_excution_role_arn"></a> [batch\_job\_excution\_role\_arn](#output\_batch\_job\_excution\_role\_arn) | n/a |
| <a name="output_batch_service_role_arn"></a> [batch\_service\_role\_arn](#output\_batch\_service\_role\_arn) | n/a |
<!-- END_TF_DOCS -->