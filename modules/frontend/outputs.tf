output "public_ip_web" {
  description = "Public IP of the web server"
  value = aws_instance.web.public_ip
}

output "instance_state_web" {
  description = "Status of the web server"
  value = aws_instance.web.instance_state
}

output "sg_id_web" {
  description = "Security Group ID of the web server"
  value = aws_security_group.web.id
}
