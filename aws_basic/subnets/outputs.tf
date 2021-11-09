output "public_subnet1_id" {
  description = "ID of public subnet 1"
  value = aws_subnet.PublicSubnet1.id
}

output "public_subnet2_id" {
  description = "ID of public subnet 2"
  value = aws_subnet.PublicSubnet2.id
}

output "public_subnet3_id" {
  description = "ID of public subnet 3"
  value = aws_subnet.PublicSubnet3.id
}

output "private_subnet1_id" {
  description = "ID of private subnet 1"
  value = aws_subnet.PrivateSubnet1.id
}

output "private_subnet2_id" {
  description = "ID of private subnet 2"
  value = aws_subnet.PrivateSubnet2.id
}

output "private_subnet3_id" {
  description = "ID of private subnet 3"
  value = aws_subnet.PrivateSubnet3.id
}
