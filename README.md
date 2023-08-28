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
