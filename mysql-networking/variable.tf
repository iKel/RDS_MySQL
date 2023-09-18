
#---------------------------------------------------------#
#               Security group vars                       #
#---------------------------------------------------------#
variable "sg-name" {
  default = "dev-rds-sg"
}

variable "default-vpc-id" {
  default = "vpc-6340cb1e"
}

variable "from_port" {   
  default = "3306"
}

variable "to_port" {  
  default = "3306"
}

variable "cidr_block_engress" {
  default = ["0.0.0.0/0"]
}

variable "protol_engress" {
  default = "tcp"
}

variable "from_port_egress" {
  default = 0
}

variable "to_port_egress" {
  default = 0
}

variable "protol_egress" {
  default = "-1"
}

variable "cidr_block_egress" {
  default = ["0.0.0.0/0"]
}

#---------------------------------------------------------#
#                       VPC subnet vars                   #
#---------------------------------------------------------#

variable "aws_region" {
  default = "us-east-1"
}

variable "subnet_addresses" {
  description = "A list of subnet addresses for the subnets"
}

variable "availability_zone" {
  type        = list(string)
  description = "A list of availability zones to assign to subnets"
}

variable "subnet_group" {
  description = "Such as Corp, Inf, used to name subnets"
}

variable "subnet_group_name" {
  default = "mysql-subnet-group"

}
