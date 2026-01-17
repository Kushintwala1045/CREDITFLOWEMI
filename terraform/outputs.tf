output "security_group_id" {
  value = aws_security_group.emi_sg.id
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}