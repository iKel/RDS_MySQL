#---------------------------------------------------------#
#                  Security Group for RDS                 #
#---------------------------------------------------------#
resource "aws_security_group" "rds_sg" {
  name        = var.sg-name
  description = "Allow TCP to MySQL inbound traffic"
  vpc_id      = var.default-vpc-id

  ingress {
    description = "Allow TCP from MySQL inbound traffic"
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protol_engress
    cidr_blocks = var.cidr_block_engress

  }
  egress {
    from_port   = var.from_port_egress
    to_port     = var.to_port_egress
    protocol    = var.protol_egress
    cidr_blocks = var.cidr_block_egress
  }
  tags = {
    Name = "rds-sg"
  }
}

#---------------------------------------------------------#
#                      DB Subnet Group                    #
#---------------------------------------------------------#
resource "aws_db_subnet_group" "mysql_db_subnet" {
  name        = var.subnet_group_name
  description = "Subnet group for RDS MySQL instance"
  subnet_ids  = aws_subnet.versus_db_private_subnet.*.id

}
data "aws_region" "current" {}

#---------------------------------------------------------#
#                     Subnet resource                     #
#---------------------------------------------------------#
resource "aws_subnet" "versus_db_private_subnet" {
  count             = length(var.subnet_addresses)
  vpc_id            = var.default-vpc-id
  cidr_block        = element(var.subnet_addresses, count.index)
  availability_zone = "${data.aws_region.current.name}${element(var.availability_zone, count.index)}"

  tags = {
    Name = "${var.subnet_group}subnet-${count.index + 1}"
  }
}
