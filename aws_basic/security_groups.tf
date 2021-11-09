resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id
  name = "web_sg"
  description = "allow http and https"
  ingress = [ 
    {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "allow http"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      ipv6_cidr_blocks = [ "::/0" ]
      prefix_list_ids = [ ]
      security_groups = [ ]
      self = false
    } ,
    {
      cidr_blocks = [ "0.0.0.0/0" ]
      ipv6_cidr_blocks = [ "::/0" ]
      description = "allow https"
      from_port = 443
      to_port = 443
      protocol = "tcp"
      ipv6_cidr_blocks = [ "::/0" ]
      prefix_list_ids = [ ]
      security_groups = [ ]
      self = false
    } 
  ]
  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow all"
    protocol = "-1"
    from_port = 0
    to_port = 0
    ipv6_cidr_blocks = [ "::/0" ]
    prefix_list_ids = [ ]
    security_groups = [ ]
    self = false
  } ]
  tags = {
    "Name" = "Web SecurityGroup"
  }
}

resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.main.id
  name = "bastion_sg"
  description = "allow ssh access"
  ingress = [ 
    {
      cidr_blocks = [ "allow-ip" ]
      description = "description"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      ipv6_cidr_blocks = [ ]
      prefix_list_ids = [ ]
      security_groups = [ ]
      self = false
    } ,
  ]
  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow all"
    protocol = "-1"
    from_port = 0
    to_port = 0
    ipv6_cidr_blocks = [ "::/0" ]
    prefix_list_ids = [ ]
    security_groups = [ ]
    self = false
  } ]
  tags = {
    "Name" = "Bastion SecurityGroup"
  }
}

resource "aws_security_group" "ssh_security_group" {
  vpc_id = aws_vpc.main.id
  name = "ssh_sg"
  description = "allow ssh access from bastion"
  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow all"
    protocol = "-1"
    from_port = 0
    to_port = 0
    ipv6_cidr_blocks = [ "::/0" ]
    prefix_list_ids = [ ]
    security_groups = [ ]
    self = false
  } ]
  tags = {
    "Name" = "ssh SecurityGroup"
  }
  depends_on = [
    aws_security_group.bastion_sg
  ]
}

resource "aws_security_group_rule" "from_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  description = "from bastion"
  security_group_id = aws_security_group.ssh_security_group.id
  source_security_group_id = aws_security_group.bastion_sg.id
  
  lifecycle {
    create_before_destroy = true
  }
}
