output "instance_ids" {
  value = aws_instance.ec2[*].id
}

output "instance_types" {
  value = aws_instance.ec2[*].instance_type
}

output "private_ips" {
  value = aws_instance.ec2[*].private_ip
}

output "vpc_ids" {
  value = aws_instance.ec2[*].vpc_security_group_ids
}

output "subnet_ids" {
  value = aws_instance.ec2[*].subnet_id
}

output "key_names" {
  value = aws_instance.ec2[*].key_name
}

output "public_ips" {
  value = aws_instance.ec2[*].public_ip
}

output "ec2_security_group_id" {
  value = aws_security_group.backend.id
}

output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.alb.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "alb_url" {
  description = "URL of the ALB"
  value       = "http://${aws_lb.alb.dns_name}"
}

output "target_group_health" {
  description = "Health check status of instances"
  value       = aws_lb_target_group.ec2.health_check
}