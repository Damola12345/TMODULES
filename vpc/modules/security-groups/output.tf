output "alb_sg_id" {
  value = aws_security_group.alb-security-group.id
}

output "ssh_sg_id" {
  value = aws_security_group.ssh-security-group.id
}
