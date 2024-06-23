output "subnet_id" {
  value = aws_subnet.tpot.id
}

output "vpc_security_group_id" {
  value = aws_security_group.tpot.id
}
