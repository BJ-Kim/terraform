variable "region" {
  description = "select region"
  type = string
  default = "ap-northeast-2"
}

variable "profile" {
  description = "select profile"
  type = string
  default = "default"
}

variable "vpc_cidr_block" {
  description = "cidr block"
  type = string
  default = "10.0.0.0/16"
}
