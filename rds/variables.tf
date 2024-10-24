# Allocated storage for RDS (in GB)
variable "allocated_storage" {
  description = "The size of the database (in gigabytes)."
  type        = number
  default     = 20
}

# MySQL engine version
variable "engine_version" {
  description = "The MySQL engine version."
  type        = string
  default     = "8.0"
}

# RDS Instance Class
variable "instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

# Database Identifier
variable "db_identifier" {
  description = "The name of the RDS instance."
  type        = string
}

# Database Username
variable "username" {
  description = "Username for the database."
  type        = string
}

# Database Password
variable "password" {
  description = "Password for the database."
  type        = string
  sensitive   = true
}

# Subnet Group Name
variable "subnet_group_name" {
  description = "Name of the subnet group."
  type        = string
}

# List of Subnet IDs (private subnets for the RDS instance)
variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group (should be private subnets)."
  type        = list(string)
}

# VPC Security Group IDs
variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate with the RDS instance."
  type        = list(string)
}

# Enable Multi-AZ
variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
  default     = false
}

# Skip Final Snapshot
variable "skip_final_snapshot" {
  description = "Skip taking a final snapshot before deleting the DB instance."
  type        = bool
  default     = true
}

# Storage Type (standard, gp2, or io1)
variable "storage_type" {
  description = "The storage type to use for the RDS instance."
  type        = string
  default     = "gp2"
}

# Backup Retention Period
variable "backup_retention_period" {
  description = "The number of days to retain backups for."
  type        = number
  default     = 7
}

# Delete Automated Backups
variable "delete_automated_backups" {
  description = "Whether to delete automated backups immediately after the DB instance is deleted."
  type        = bool
  default     = true
}
