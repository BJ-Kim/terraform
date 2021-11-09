module "eks_manager_server" {
  source = "./modules/instances"

  instance_type = "t3.small"
  subnet_id = "${module.subnets.private_subnet1_id}"
  key_name = "key-name"
  instance_name = "k8s-server"
  volume_size = 10
  associate_public_ip_address = false
  sg_ids = [
    "${aws_security_group.web_sg.id}",
    "${aws_security_group.ssh_security_group.id}"
  ]
}
