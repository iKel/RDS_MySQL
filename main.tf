module "mysql" {
  source               = "../mysql"
  rds_sg_id            = module.mysql-networking.mysql-sg-id
  db_subnet_group_name = module.mysql-networking.sb-gr-md

  #DB configuration
  identifier                             = var.identifier
  db_engine                              = var.db_engine
  bd_engine_version                      = var.bd_engine_version
  db_instance_class                      = var.db_instance_class
  db_name                                = var.db_name
  db_allocated_storage                   = var.db_allocated_storage
  db_max_allocated_storage               = var.db_max_allocated_storage
  skip_final_snapshot_db                 = var.skip_final_snapshot_db
  copy_tags_to_snapshot_db               = var.copy_tags_to_snapshot_db
  multi_az_db                            = var.multi_az_db
  deletion_protection_db                 = var.deletion_protection_db
  iam_database_authentication_enabled_db = var.iam_database_authentication_enabled_db
  performance_insights                   = var.performance_insights
  # Backup cinfiguration
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window
  maintenance_window              = var.maintenance_window
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  secret_name                     = var.secret_name
  # iam database authentication
  iam_role_name   = var.iam_role_name
  iam_policy_name = var.iam_policy_name

}

module "mysql-networking" {
  source = "../mysql-networking"

  #Security group variables
  sg-name            = var.sg-name
  default-vpc-id     = var.default-vpc-id
  from_port          = var.from_port
  to_port            = var.to_port
  cidr_block_engress = var.cidr_block_engress
  protol_engress     = var.protol_engress
  from_port_egress   = var.from_port_egress
  to_port_egress     = var.to_port_egress
  protol_egress      = var.protol_egress
  cidr_block_egress  = var.cidr_block_egress

  #vpc subnet var.
  aws_region        = var.aws_region
  subnet_addresses  = var.subnet_addresses
  availability_zone = var.availability_zone
  subnet_group      = var.subnet_group
  subnet_group_name = var.subnet_group_name


}
