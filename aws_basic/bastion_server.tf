module "bastion_server" {
  source = "./modules/instances"

  instance_type = "t3.nano"
  subnet_id = "${module.subnets.public_subnet2_id}"
  key_name = "key-name"
  instance_name = "bastion host"
  volume_size = 10
  associate_public_ip_address = true
  sg_ids = [
    "${aws_security_group.bastion_sg.id}"
  ]
}
