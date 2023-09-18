output "mysql-sg-id" {
  value = aws_security_group.rds_sg.id
}

output "sb-gr-md" {
  value = aws_db_subnet_group.mysql_db_subnet.id
}

