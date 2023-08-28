provider "aws" {
  default_tags {
    tags = var.default_tags
  }
}

resource "aws_secretsmanager_secret" "github_app" {
  name = var.secret_name
  description = "Github App Private Key"
  recovery_window_in_days = var.recovery_window_in_days
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id = aws_secretsmanager_secret.github_app.id
  secret_string = try(file(var.secret_values), jsonencode(var.secret_values))
  depends_on = [
    aws_secretsmanager_secret.github_app
  ]
}