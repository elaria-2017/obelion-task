variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

variable "allocated_storage" {
  description = "The size of the database (in gigabytes)."
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "The MySQL engine version."
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "db_identifier" {
  description = "The name of the RDS instance."
  type        = string
}

variable "username" {
  description = "Username for the database."
  type        = string
}

variable "password" {
  description = "Password for the database."
  type        = string
  sensitive   = true
}

variable "subnet_group_name" {
  description = "Name of the subnet group."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group (should be private subnets)."
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate with the RDS instance."
  type        = list(string)
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip taking a final snapshot before deleting the DB instance."
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "The storage type to use for the RDS instance."
  type        = string
  default     = "gp2"
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for."
  type        = number
  default     = 7
}

variable "delete_automated_backups" {
  description = "Whether to delete automated backups immediately after the DB instance is deleted."
  type        = bool
  default     = true
}


variable "security_group_name" {
  
}


variable "inport" {
  
}
