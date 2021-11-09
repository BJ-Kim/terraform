variable "region" {
  default     = "ap-northeast-2"
  description = "AWS region"
}

variable "profile" {
  default = "default"
  description = "AWS profile"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  cluster_name = "cluster-${random_string.suffix.result}"
}
