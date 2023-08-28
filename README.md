# aws-batch-github-actions-runner
AWS Batch for self hosted GitHub action runners.

We will use Docker Image from repo [github.com/myoung34/docker-github-actions-runner](https://github.com/myoung34/docker-github-actions-runner). Credit to [Marc](https://github.com/myoung34) for his amazing work.

![AWS Batch Github Runner](/assets/aws-batch-gh-runner-diagram.PNG "AWS Batch Github Runner Diagram")

## How to setup

### 1. Setup GitHub App ###

Go to GitHub and [create a new app](https://docs.github.com/en/developers/apps/creating-a-github-app). Beware you can create apps your organization or for a user.

1. Create app in Github
2. Choose a name
3. Choose a website (mandatory, not required for the module).
4. Disable the webhook for now.
5. Permissions for all runners:
    - Repository:
      - `Actions`: Read-only (check for queued jobs)
      - `Checks`: Read-only (receive events for new builds)
      - `Metadata`: Read-only (default/required)
6. _Permissions for repo level runners only_:
   - Repository:
     - `Administration`: Read & write (to register runner)
7. _Permissions for organization level runners only_:
   - Organization
     - `Self-hosted runners`: Read & write (to register runner)
8. Save the new app.
9. On the General page, make a note of the "App ID" parameters.
10. Generate a new private key and save the `app.pem` file to `configs` folder.

### 2. Local test with Docker ###

For more environment option / Usage, please visit [github.com/myoung34/docker-github-actions-runner](https://github.com/myoung34/docker-github-actions-runner) or [github.com/myoung34/docker-github-actions-runner/wiki](https://github.com/myoung34/docker-github-actions-runner/wiki/Usage)

### Use with Github App in Repo level, Ephemeral runner ###

```bash
docker run -d --restart always --name github-runner \
  -e EPHEMERAL="1" \
  -e APP_ID="your-app-id" \
  -e APP_PRIVATE_KEY="GitHub App Private Key" \
  -e REPO_URL="https://github.com/<your-username>/<your-repo>" \
  -e RUNNER_NAME_PREFIX="github-runner" \
  -e LABELS="label-1,label-2" \
myoung34/github-runner:latest
```

### Use with Github App in Org level, Ephemeral runner ###

```bash
docker run -d --restart always --name github-runner \
  -e EPHEMERAL="1" \
  -e APP_ID="your-app-id" \
  -e APP_PRIVATE_KEY="GitHub App Private Key" \
  -e RUNNER_SCOPE="org" \
  -e ORG_NAME="<your-org-name>" \
  -e RUNNER_NAME_PREFIX="github-runner" \
  -e LABELS="my-label,other-label" \
  myoung34/github-runner:latest
  ```
### 4. Edit config ###
Change/Review all file in configs folder to match with your parameters.

In main.tf update necessary parameters in `locals` to fit with your needs.
  - `region = "ap-southeast-1"`   AWS Region
  - `org_id = "your-org-id"`      Your Org ID
  - `org_user_ids = ["user1", "user2"]`     List of user-id approved to run this runner
  - `github_app_id = "2xxxxx8"`     Github App ID in `step 1`

### 5. Run `terraform init` && `terraform plan` && `terraform apply --auto-approve`
### 6. Set Webhook to Github App ###
Use API Gateway URL from `Step 5` Output and Set it in `Webhook URL` of your Github App in `Step 1`. Don't forget tick on `Active`

## Use in workflow
- If you set `ec2` in `runs-on` parameter of your workflow, job will run on container in EC2 instance.
```bash
jobs:
  render-docs:
    runs-on: [self-hosted, ec2]
```
- If you set `fargate` in `runs-on` parameter of your workflow, job will run on Fargate.
```bash
jobs:
  render-docs:
    runs-on: [self-hosted, fargate]
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | ./modules/api-gateway | n/a |
| <a name="module_batch"></a> [batch](#module\_batch) | ./modules/batch | n/a |
| <a name="module_iam_role"></a> [iam\_role](#module\_iam\_role) | ./modules/iam | n/a |
| <a name="module_secrets_manager"></a> [secrets\_manager](#module\_secrets\_manager) | ./modules/secrets-manager | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | 4.9.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.1.0 |

## Resources

| Name | Type |
|------|------|
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | (Required) Default tag for AWS resource | `map` | <pre>{<br>  "component": "main",<br>  "env": "dev",<br>  "github_repo": "",<br>  "project": "terraform-aws-batch-github-runner"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_invoke_url"></a> [api\_gateway\_invoke\_url](#output\_api\_gateway\_invoke\_url) | URL of API Gateway Webhook, use to set in GitHub App webhook |
| <a name="output_batch_job_definition"></a> [batch\_job\_definition](#output\_batch\_job\_definition) | A set of AWS Batch job definiton |
| <a name="output_ec2_batch_job_queue"></a> [ec2\_batch\_job\_queue](#output\_ec2\_batch\_job\_queue) | Set of EC2 batch job queue |
| <a name="output_fargate_batch_job_queue"></a> [fargate\_batch\_job\_queue](#output\_fargate\_batch\_job\_queue) | Set of fargate batch job queue |
| <a name="output_secret_app_key"></a> [secret\_app\_key](#output\_secret\_app\_key) | ARN of the GitHub App Private key stored in Secret Manager |
<!-- END_TF_DOCS -->