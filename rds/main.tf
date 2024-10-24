# MySQL RDS Instance
resource "aws_db_instance" "mysql" {
  allocated_storage    = var.allocated_storage
  engine               = "mysql"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = var.db_identifier
  username             = var.username
  password             = var.password
  db_subnet_group_name = var.subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  multi_az             = var.multi_az
  publicly_accessible  = false  # No internet exposure
  skip_final_snapshot  = var.skip_final_snapshot
  storage_type         = var.storage_type
  backup_retention_period = var.backup_retention_period
  delete_automated_backups = var.delete_automated_backups

  tags = {
    Name = var.db_identifier
  }
}

