output "secret_id" {
  value = aws_secretsmanager_secret.github_app.id
}

output "secret_arn" {
  value = aws_secretsmanager_secret.github_app.arn
}