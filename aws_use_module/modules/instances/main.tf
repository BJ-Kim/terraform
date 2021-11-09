resource "aws_instance" "instance" {
  ami = "ami-00f1068284b9eca92" # ubuntu community version
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  key_name = "${var.key_name}"
  disable_api_termination = false
  ebs_optimized = false
  monitoring = false
  vpc_security_group_ids = var.sg_ids
  tags = {
    "Name" = "${var.instance_name}"
  }
  associate_public_ip_address = var.associate_public_ip_address
  root_block_device {
    delete_on_termination = true
    encrypted = true
    volume_size = var.volume_size
    volume_type = "gp3"
  }
}
