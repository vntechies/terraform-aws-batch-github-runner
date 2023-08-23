output "batch_job_definition" {
  value = module.batch.batch_job_definition
}
output "fargate_batch_job_queue" {
  value = module.batch.fargate_batch_job_queue
}
output "ec2_batch_job_queue" {
  value = module.batch.ec2_batch_job_queue
}
output "secret_app_key" {
  value = module.secrets_manager.secret_arn
}
output "api_gateway_invoke_url" {
  value = module.api_gateway.api_invoke_url
}