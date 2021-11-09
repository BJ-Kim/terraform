# data "terraform_remote_state" "vpc" {
#   backend = "s3"
#   config = {
#     bucket  = "bucket-name"
#     key     = "key-name"
#     profile = "profile-name"
#     region = "ap-northeast-2"
#   }
# }

resource "aws_internet_gateway" "main_igw" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "Main IGW"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "PublicRouteTable"
  }
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main_igw.id
  depends_on = [
    aws_internet_gateway.main_igw,
    aws_route_table.public_route_table
  ]
}

resource "aws_subnet" "PublicSubnet1" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_blocks[0]
  availability_zone = var.subnet_azs[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.public_subnet_name}1"
  }
}
resource "aws_route_table_association" "PublicSubnet1RouteTableAssociation" {
  subnet_id = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_subnet" "PublicSubnet2" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_blocks[1]
  availability_zone = var.subnet_azs[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.public_subnet_name}2"
  }
}
resource "aws_route_table_association" "PublicSubnet2RouteTableAssociation" {
  subnet_id = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_subnet" "PublicSubnet3" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_blocks[2]
  availability_zone = var.subnet_azs[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.public_subnet_name}3"
  }
}
resource "aws_route_table_association" "PublicSubnet3RouteTableAssociation" {
  subnet_id = aws_subnet.PublicSubnet3.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_eip" "nat_gateway_eip" {
  tags = {
    "Name" = "NatGatewayIp"
  }
}
resource "aws_nat_gateway" "nat_gateway1" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id = aws_subnet.PublicSubnet1.id
  depends_on = [
    aws_eip.nat_gateway_eip
  ]
}
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "PrivateRouteTable"
  }
}
resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway1.id
  depends_on = [
    aws_nat_gateway.nat_gateway1,
    aws_route_table.private_route_table
  ]
}
resource "aws_subnet" "PrivateSubnet1" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_blocks[3]
  availability_zone = var.subnet_azs[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.private_subnet_name}1"
  }
}
resource "aws_route_table_association" "PrivateSubnet1RouteTableAssociation" {
  subnet_id = aws_subnet.PrivateSubnet1.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_subnet" "PrivateSubnet2" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_blocks[4]
  availability_zone = var.subnet_azs[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.private_subnet_name}2"
  }
}
resource "aws_route_table_association" "PrivateSubnet2RouteTableAssociation" {
  subnet_id = aws_subnet.PrivateSubnet2.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_subnet" "PrivateSubnet3" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_blocks[5]
  availability_zone = var.subnet_azs[2]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.private_subnet_name}3"
  }
}
resource "aws_route_table_association" "PrivateSubnet3RouteTableAssociation" {
  subnet_id = aws_subnet.PrivateSubnet3.id
  route_table_id = aws_route_table.private_route_table.id
}

