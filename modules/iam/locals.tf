locals {
  app_env_prefix = "${lookup(var.default_tags, "component", "-")}-${lookup(var.default_tags, "env", "-")}"
}
