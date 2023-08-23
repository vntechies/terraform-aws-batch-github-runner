<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | 4.9.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | app.terraform.io/tnx-journey-to-cloud/vpc/aws | 1.1.4 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | (Required) Default tag for AWS resource | `map` | <pre>{<br>  "component": "networks",<br>  "env": "dev",<br>  "github_repo": "",<br>  "project": "github-runner-batch"<br>}</pre> | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | `map` | <pre>{<br>  "github-runner-batch": {<br>    "igw_config": {<br>      "igw_enable": true,<br>      "rtb_name": "public_rtb"<br>    },<br>    "route_table_setting": {},<br>    "subnets": {<br>      "public_subnet1": {<br>        "az": "ap-southeast-1a",<br>        "cidr": "10.1.1.0/24",<br>        "route_table_name": "public_rtb",<br>        "subnet_tags": {<br>          "group": "public_subnet",<br>          "public_subnet1": "ap-southeast-1a"<br>        }<br>      },<br>      "public_subnet2": {<br>        "az": "ap-southeast-1b",<br>        "cidr": "10.1.2.0/24",<br>        "route_table_name": "public_rtb",<br>        "subnet_tags": {<br>          "group": "public_subnet",<br>          "public_subnet2": "ap-southeast-1b"<br>        }<br>      },<br>      "public_subnet3": {<br>        "az": "ap-southeast-1c",<br>        "cidr": "10.1.3.0/24",<br>        "route_table_name": "public_rtb",<br>        "subnet_tags": {<br>          "group": "public_subnet",<br>          "public_subnet3": "ap-southeast-1c"<br>        }<br>      }<br>    },<br>    "vpc_cidr_block": "10.1.0.0/16"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | n/a |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->