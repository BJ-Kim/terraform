variable "instance_type" {
  type = string
  default = "t3.small"
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "volume_size" {
  type = number
}

variable "sg_ids" {
  type = set(string)
}

variable "associate_public_ip_address" {
  type = bool
}
