# Outputs from module
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_instance_id" {
  value = module.rds.rds_instance_id
}

