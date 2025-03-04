output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "security_group_id" {
  value = aws_security_group.backend.id
}