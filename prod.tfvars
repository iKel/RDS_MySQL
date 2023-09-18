#---------------------------------------------------------#
#                   DB configuration                      #
#---------------------------------------------------------#
identifier                             = "prod-versus-mysql-db"
db_engine                              = "mysql"
bd_engine_version                      = "5.7"
db_instance_class                      = "db.t2.micro"
db_name                                = "prodsampledb"
db_allocated_storage                   = 15 #Gi
db_max_allocated_storage               = 20 #Gi
skip_final_snapshot_db                 = true
copy_tags_to_snapshot_db               = true
multi_az_db                            = true
deletion_protection_db                 = false
iam_database_authentication_enabled_db = true
performance_insights                   = false

secret_name = "prod-mysql-cred-v4"
#---------------------------------------------------------#
#             Backup configuration section                #
#---------------------------------------------------------#
backup_retention_period         = 3
backup_window                   = "00:00-03:00"
maintenance_window              = "sat:03:01-sat:06:00"
enabled_cloudwatch_logs_exports = ["audit", "general", "error", "slowquery"]

#---------------------------------------------------------#
#                   Security group vars                   #
#---------------------------------------------------------#
sg-name            = "prod-rds-sg"
default-vpc-id     = "vpc-073fd1e21e8670e06"
from_port          = "3306"
to_port            = "3306"
cidr_block_engress = ["0.0.0.0/0"]
protol_engress     = "tcp"
from_port_egress   = 0
to_port_egress     = 0
protol_egress      = "-1"
cidr_block_egress  = ["0.0.0.0/0"]
#---------------------------------------------------------#
#                     VPC subnet vars                     #
#---------------------------------------------------------#
aws_region = "us-east-1"
subnet_addresses = [
  "10.0.0.0/26",
  "10.0.0.64/26",
  "10.0.0.128/26",
]

availability_zone = [
  "a",
  "b",
  "c"
]
subnet_group      = "prod-mysql-pv"
subnet_group_name = "prod-mysql-subnet-group"
#---------------------------------------------------------#
#               IAM DB authentication                     #
#---------------------------------------------------------#
iam_policy_name = "prod_mysql_iam_auth_policy"
iam_role_name   = "prod_mysql_iam_role_policy"
