# RDS Endpoint
output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance."
  value       = aws_db_instance.mysql.endpoint
}

# RDS Instance ID
output "rds_instance_id" {
  description = "The ID of the RDS instance."
  value       = aws_db_instance.mysql.id
}
