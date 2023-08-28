locals {
  api_invoke_url = "${aws_api_gateway_stage.stage.invoke_url}${aws_api_gateway_resource.webhook.path}"
}

resource "aws_api_gateway_rest_api" "github_batch" {
  name = "github-batch"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  depends_on = [
    var.apigw_excution_role_arn,
    var.model_json_schema,
    var.integration_mapping_model
  ] 
  tags = var.default_tags
}
resource "aws_api_gateway_resource" "webhook" {
  rest_api_id = aws_api_gateway_rest_api.github_batch.id
  parent_id = aws_api_gateway_rest_api.github_batch.root_resource_id
  path_part = var.api_gateway_path
  depends_on = [
    var.apigw_excution_role_arn,
    var.model_json_schema,
    var.integration_mapping_model
  ] 
}
resource "aws_api_gateway_method" "post" {
  rest_api_id = aws_api_gateway_rest_api.github_batch.id
  resource_id = aws_api_gateway_resource.webhook.id
  http_method = "POST"
  authorization = "NONE"
  request_validator_id = aws_api_gateway_request_validator.validate_request.id
  request_parameters = {
    "method.request.header.X-GitHub-Event" = true,
    "method.request.header.X-GitHub-Hook-ID" = true,
    "method.request.header.X-GitHub-Hook-Installation-Target-ID" = true,
    "method.request.header.X-GitHub-Hook-Installation-Target-Type" = true,
    "method.request.header.X-Hub-Signature" = true,
    "method.request.header.X-Hub-Signature-256" = true
  }
  request_models = {
    "application/json" = "${aws_api_gateway_model.github_webhook.name}"
  }
  depends_on = [
    aws_api_gateway_rest_api.github_batch,
    aws_api_gateway_resource.webhook,
    aws_api_gateway_model.github_webhook
  ]
}

resource "aws_api_gateway_integration" "api_to_batch" {
  http_method = aws_api_gateway_method.post.http_method
  resource_id = aws_api_gateway_resource.webhook.id
  rest_api_id = aws_api_gateway_rest_api.github_batch.id
  integration_http_method = "POST"
  type = "AWS"
  uri = "arn:aws:apigateway:${var.region}:batch:path/v1/submitjob"
  credentials = var.apigw_excution_role_arn
  request_templates = {
    "application/json" = try(var.integration_mapping_model, "")
  }
  passthrough_behavior = "WHEN_NO_TEMPLATES"
  depends_on = [
    var.apigw_excution_role_arn,
    var.integration_mapping_model
  ]
}

resource "aws_api_gateway_model" "github_webhook" {
  rest_api_id = aws_api_gateway_rest_api.github_batch.id
  name = "GitHubWebhook"
  description = "A GitHub Webhook JSON Schema"
  content_type = "application/json"
  schema = try(var.model_json_schema,{})
  depends_on = [
    var.model_json_schema
  ]
}

resource "aws_api_gateway_request_validator" "validate_request" {
  name = "validate-request"
  rest_api_id = aws_api_gateway_rest_api.github_batch.id
  validate_request_body = true
  validate_request_parameters = true
}
resource "aws_api_gateway_method_response" "response" {
  rest_api_id = aws_api_gateway_rest_api.github_batch.id
  resource_id = aws_api_gateway_resource.webhook.id
  http_method = aws_api_gateway_method.post.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "batch_response_apigw" {
  rest_api_id = aws_api_gateway_rest_api.github_batch.id
  resource_id = aws_api_gateway_resource.webhook.id
  http_method = aws_api_gateway_method.post.http_method
  status_code = "200"
  depends_on = [
    aws_api_gateway_rest_api.github_batch,
    aws_api_gateway_resource.webhook,
    aws_api_gateway_method.post,
    aws_api_gateway_method_response.response
  ]
}
resource "aws_api_gateway_deployment" "deploy" {
  rest_api_id = aws_api_gateway_rest_api.github_batch.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.webhook.id,
      aws_api_gateway_method.post.id,
      aws_api_gateway_integration.api_to_batch.id,
      aws_api_gateway_request_validator.validate_request.id,
      aws_api_gateway_method_response.response.id,
      aws_api_gateway_integration_response.batch_response_apigw.id,
      var.model_json_schema,
      var.integration_mapping_model,
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }  
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deploy.id
  rest_api_id = aws_api_gateway_rest_api.github_batch.id
  stage_name = var.api_gateway_stage_name
  depends_on = [
    aws_api_gateway_deployment.deploy
  ]
  tags = var.default_tags
}