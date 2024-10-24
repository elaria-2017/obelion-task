module "vpc" {
  source          = "./vpc"
  vpc_cidr        = var.vpc_cidr
  vpc_name        = var.vpc_name
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
 security_group_name = var.security_group_name
 inport = var.inport
}


module "rds" {
  source                  = "./rds"
  allocated_storage       = var.allocated_storage
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_identifier           = var.db_identifier
  username                = var.username
  password                = var.password
  subnet_group_name       = module.vpc.subnet_group
  subnet_ids              = module.vpc.private_subnets
  vpc_security_group_ids  = [module.vpc.sg_id]
  multi_az                = var.multi_az
  skip_final_snapshot     = var.skip_final_snapshot
  storage_type            = var.storage_type
  backup_retention_period = var.backup_retention_period
  delete_automated_backups = var.delete_automated_backups
}

module "backend_machine" {
  source                      = "./ec2"
  ec2_name                    = "backend"
  ec2_ami                     = "ami-0866a3c8686eaeeba"
  ec2_type                    = "t2.micro"
  SG_id                       = [module.vpc.sg_id]
  ec2_subnet_ID               = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_pair                    = "elaria"
  user_data                   = file("./install.sh")
}


module "frontend_machine" {
  source                      = "./ec2"
  ec2_name                    = "frontend"
  ec2_ami                     = "ami-0866a3c8686eaeeba"
  ec2_type                    = "t2.micro"
  SG_id                       = [module.vpc.sg_id]
  ec2_subnet_ID               = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_pair                    = "elaria"
  user_data                   = file("./install.sh")
}