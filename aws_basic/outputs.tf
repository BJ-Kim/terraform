output "main_vpc_id" {
  description = "ID of main vpc"
  value = aws_vpc.main.id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_sg.id
}

output "web_security_group_id" {
  value = aws_security_group.web_sg.id
}

output "ssh_security_group_id" {
  value = aws_security_group.ssh_security_group.id
}

output "bastion_server_id" {
  value = aws_instance.bastion_server.id
}
