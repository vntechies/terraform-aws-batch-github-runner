## AWS Batch - Compute Service Role ##
resource "aws_iam_role" "batch_compute_service_role" {
  name = "githubBatchComputeServiceRole"

  managed_policy_arns = [ data.aws_iam_policy.batch_service_link_role.arn ]
  force_detach_policies = true
  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
            "Service": "batch.amazonaws.com"
          }            
        }
      ]
    }
  EOF

  lifecycle {
    create_before_destroy = true
  }
  tags = var.default_tags
}

data "aws_iam_policy" "batch_service_link_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

## AWS Batch - ECS Task Excution Role ##

resource "aws_iam_role" "job_def_excution_role" {
  name = "githubBatchJobExcutionRole"

  managed_policy_arns = [ data.aws_iam_policy.ecs_task_excution_role_managed.arn ]
  force_detach_policies = true
  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
            "Service": "ecs-tasks.amazonaws.com"
          }            
        }
      ]
    }
  EOF

  inline_policy {
    name = "ReadSecretGithubApp"
    policy = data.aws_iam_policy_document.read_secret_resource.json
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = var.default_tags
}

data "aws_iam_policy_document" "read_secret_resource" {
  statement {
    sid = "readSecretResource"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = [ "${var.secret_resource_arn}" ]
  }
  depends_on = [
    var.secret_resource_arn
  ]  
}

data "aws_iam_policy" "ecs_task_excution_role_managed" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

## API Gateway - Excution Role ##
resource "aws_iam_role" "api_gateway_excution_role" {
  name = "apiGatewayExcutionRoleBatch"

  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
            "Service": "apigateway.amazonaws.com"
          }
        }
      ]
    }
  EOF

  inline_policy {
    name = "SubmitBatchJobs"
    policy = data.aws_iam_policy_document.apigw_submit_batch_jobs.json
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = var.default_tags
}

data "aws_iam_policy_document" "apigw_submit_batch_jobs" {
  statement {
    sid = "SubmitBatchJobs"
    effect = "Allow"
    actions = [
      "batch:SubmitJob",
      "batch:TagResource",
    ]
    resources = [ "*" ]
  }
}
### AWS Batch - ECS EC2 Instance Role ###
resource "aws_iam_role" "ecs_instance_role" {
  name = "github_ecs_instance_role"
  managed_policy_arns = [ data.aws_iam_policy.ecs_instance_role.arn ]
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            }
        }
        ]
    }
  EOF
  tags = var.default_tags
}

data "aws_iam_policy" "ecs_instance_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = aws_iam_role.ecs_instance_role.name
  role = aws_iam_role.ecs_instance_role.name
  tags = var.default_tags
}
