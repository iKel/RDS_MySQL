#---------------------------------------------------------#
#                   DB configuration                      #
#---------------------------------------------------------#

variable "rds_sg_id" {
  type = string
}
variable "db_subnet_group_name" {
  type = string
}
variable "identifier" {
  default = "dev-versus-mysql-db"
}
variable "db_engine" {
  default = "mysql"
}
variable "bd_engine_version" {
  default = "5.7"
}
variable "db_instance_class" {
  default = "db.t2.micro"
}
variable "db_name" {
  default = "sampledb"
}
variable "db_allocated_storage" {
  default = 10 #Gi
}
variable "db_max_allocated_storage" {
  default = 20 #Gi
}

variable "skip_final_snapshot_db" {
  default = true
}
variable "copy_tags_to_snapshot_db" {
  default = false
}
variable "multi_az_db" {
  default = false
}
variable "deletion_protection_db" {
  default = false
}
variable "iam_database_authentication_enabled_db" {
  default = false
}
variable "performance_insights" {
  default = false
}

#---------------------------------------------------------#
#           Backup configuration section                  #
#---------------------------------------------------------#
variable "backup_retention_period" {
  default = 7
}
variable "backup_window" {
  default = "00:00-03:00"
}
variable "maintenance_window" {
  default = "sat:03:01-sat:06:00"
}
variable "enabled_cloudwatch_logs_exports" {
  default = ["audit", "general", "error", "slowquery"]
}
variable "secret_name" {
}
#---------------------------------------------------------#
#                   IAM DB authentication                 #
#---------------------------------------------------------#
variable "iam_role_name" {
  type = string
}
variable "iam_policy_name" {
  type = string
}
