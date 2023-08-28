output "secret_id" {
  description = "ID of Secret store in secret manager"
  value = aws_secretsmanager_secret.github_app.id
}

output "secret_arn" {
  description = "ARN of Secret store in secret manager"
  value = aws_secretsmanager_secret.github_app.arn
}
