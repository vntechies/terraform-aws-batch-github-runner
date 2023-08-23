output "vpc_id" {
    value = module.vpc["github-runner-batch"].vpc_id  
}
output "subnet_ids" {
    value = [ for k, v in module.vpc["github-runner-batch"].subnet_ids : v ]
}
output "security_group" {
    value = module.security_group.security_group_id
}