variable "vpc_id" {
  type = string
}

variable "public_subnet_name" {
  type = string
  default = "PublicSubnet"
}

variable "private_subnet_name" {
  type = string
  default = "PrivateSubnet"
}

variable "subnet_cidr_blocks" {
  type = list
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}

variable "subnet_azs" {
  type = list
  default = [
    "ap-northeast-2a",
    "ap-northeast-2b",
    "ap-northeast-2c"
  ]
}
