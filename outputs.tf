output "batch_job_definition" {
  description = "A set of AWS Batch job definiton"
  value = module.batch.batch_job_definition
}
output "fargate_batch_job_queue" {
  description = "Set of fargate batch job queue"
  value = module.batch.fargate_batch_job_queue
}
output "ec2_batch_job_queue" {
  description = "Set of EC2 batch job queue"
  value = module.batch.ec2_batch_job_queue
}
output "secret_app_key" {
  description = "ARN of the GitHub App Private key stored in Secret Manager"
  value = module.secrets_manager.secret_arn
}
output "api_gateway_invoke_url" {
  description = "URL of API Gateway Webhook, use to set in GitHub App webhook"
  value = module.api_gateway.api_invoke_url
}
