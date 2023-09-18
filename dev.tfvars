#---------------------------------------------------------#
#                   DB configuration                      #
#---------------------------------------------------------#
identifier                             = "dev-versus-mysql-db"
db_engine                              = "mysql"
bd_engine_version                      = "5.7"
db_instance_class                      = "db.t2.micro"
db_name                                = "sampledb"
db_allocated_storage                   = 10 #Gi
db_max_allocated_storage               = 20 #Gi
skip_final_snapshot_db                 = true
copy_tags_to_snapshot_db               = false
multi_az_db                            = false
deletion_protection_db                 = false
iam_database_authentication_enabled_db = false
performance_insights                   = false

secret_name = "dev-mysql-creds"
#---------------------------------------------------------#
#             Backup configuration section                #
#---------------------------------------------------------#
backup_retention_period         = 7
backup_window                   = "00:00-03:00"
maintenance_window              = "sat:03:01-sat:06:00"
enabled_cloudwatch_logs_exports = ["audit", "general", "error", "slowquery"]
#---------------------------------------------------------#
#                 Security group vars                     #
#---------------------------------------------------------#
sg-name            = "dev-rds-sg"
default-vpc-id     = "vpc-6340cb1e"
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
  "172.31.144.0/20",
  "172.31.160.0/20",
  "172.31.176.0/20",
]
availability_zone = [
  "a",
  "b",
  "c"
]
subnet_group      = "dev-mysql-pv"
subnet_group_name = "mysql-subnet-group"


