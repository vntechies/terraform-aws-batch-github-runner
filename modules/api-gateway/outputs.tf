output "api_invoke_url" {
  value = try(local.api_invoke_url, "")
}