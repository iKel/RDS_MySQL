#---------------------------------------------------------#
#                     RDS DB Instance                     #                                                                   
#---------------------------------------------------------#
resource "aws_db_instance" "mysql" {

  identifier = var.identifier # name of db

  allocated_storage     = var.db_allocated_storage     # Base amount of storage space in Gi
  max_allocated_storage = var.db_max_allocated_storage # Enable and Configure RDS Storage AutoScaling
  engine                = var.db_engine
  engine_version        = var.bd_engine_version
  instance_class        = var.db_instance_class
  db_name               = var.db_name
  #Credentials
  username = local.db_creds.username # data encrypted by aws kms service 
  password = local.db_creds.password # data encrypted by aws kms service
  #DB configurations
  skip_final_snapshot                 = var.skip_final_snapshot_db 
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot_db
  multi_az                            = var.multi_az_db            
  deletion_protection                 = var.deletion_protection_db 
  iam_database_authentication_enabled = var.iam_database_authentication_enabled_db
  #Networking
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [var.rds_sg_id]
  #Backup cinfiguration section. Enable backups. 
  backup_retention_period         = var.backup_retention_period         # backup_periods in days .
  backup_window                   = var.backup_window                   # backup_window in UTC time.
  maintenance_window              = var.maintenance_window              # backup_window in UTC time.
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports 

  tags = {
    Name = "Mysql"
  }
}
#---------------------------------------------------------#
#                         AWS KMS                         #
#---------------------------------------------------------#

# create a random generated password to use in secrets.
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "@!#$%&*()-_=+[]{}<>:?"
}
# Creating a AWS secret for database master account (Masteraccoundb)
resource "aws_secretsmanager_secret" "secretmasterDB" {
  name        = var.secret_name
  description = "Access to RDS Mysql in for Versus app"
}
# Creating a AWS secret versions for database master account (Masteraccoundb)
resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.secretmasterDB.id
  secret_string = <<EOF
   {
    "username": "admin",
    "password": "${random_password.password.result}"
   }
EOF
}
# Importing the AWS secrets created previously using arn.
data "aws_secretsmanager_secret" "secretmasterDB" {
  arn = aws_secretsmanager_secret.secretmasterDB.arn
}
# Importing the AWS secret version created previously using arn.
data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.secretmasterDB.arn
}
# After importing the secrets storing into Locals
locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}

#---------------------------------------------------------#
#                 IAM DB authentication                   #  
#---------------------------------------------------------#
resource "aws_iam_role" "rds_auth_role" {
  name = var.iam_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "rds_auth_policy" {
  name = var.iam_policy_name
  role = aws_iam_role.rds_auth_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "rds-db:connect"
      ],
      "Resource": [
        "${aws_db_instance.mysql.arn}/admin"
      ]
    }
  ]
}
EOF
}

