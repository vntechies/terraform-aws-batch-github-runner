output "batch_job_definition" {
  value = { for k, v in aws_batch_job_definition.self_hosted_runner : k => "${v.name}:${v.revision}" }
}
output "fargate_batch_job_queue" {
  value = try(aws_batch_job_queue.fargate[0].name, "")
}
output "ec2_batch_job_queue" {
  value = try(aws_batch_job_queue.ec2[0].name, "")
}