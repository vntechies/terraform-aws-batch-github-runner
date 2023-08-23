output "batch_service_role_arn" {
  value = aws_iam_role.batch_compute_service_role.arn
}
output "batch_instance_role_arn" {
  value = aws_iam_instance_profile.ecs_instance_profile.arn
}
output "batch_job_excution_role_arn" {
  value = aws_iam_role.job_def_excution_role.arn
}
output "api_gateway_excution_role_arn" {
  value = aws_iam_role.api_gateway_excution_role.arn
}

