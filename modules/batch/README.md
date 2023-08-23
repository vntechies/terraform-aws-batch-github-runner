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
| [aws_batch_compute_environment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_compute_environment) | resource |
| [aws_batch_job_definition.self_hosted_runner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_definition) | resource |
| [aws_batch_job_queue.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_queue) | resource |
| [aws_batch_job_queue.fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_batch_compute_env"></a> [batch\_compute\_env](#input\_batch\_compute\_env) | n/a | `any` | n/a | yes |
| <a name="input_batch_job_definition"></a> [batch\_job\_definition](#input\_batch\_job\_definition) | n/a | `any` | n/a | yes |
| <a name="input_batch_name_prefix"></a> [batch\_name\_prefix](#input\_batch\_name\_prefix) | n/a | `string` | `"aws-batch"` | no |
| <a name="input_compute_security_group"></a> [compute\_security\_group](#input\_compute\_security\_group) | n/a | `list` | n/a | yes |
| <a name="input_compute_service_role"></a> [compute\_service\_role](#input\_compute\_service\_role) | n/a | `string` | n/a | yes |
| <a name="input_compute_subnet_ids"></a> [compute\_subnet\_ids](#input\_compute\_subnet\_ids) | n/a | `list` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | (Required) Default tag for AWS resource | `map` | <pre>{<br>  "component": "batch",<br>  "env": "dev",<br>  "github_repo": "",<br>  "project": "github-runner-batch"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_batch_job_definition"></a> [batch\_job\_definition](#output\_batch\_job\_definition) | n/a |
| <a name="output_ec2_batch_job_queue"></a> [ec2\_batch\_job\_queue](#output\_ec2\_batch\_job\_queue) | n/a |
| <a name="output_fargate_batch_job_queue"></a> [fargate\_batch\_job\_queue](#output\_fargate\_batch\_job\_queue) | n/a |
<!-- END_TF_DOCS -->