variable "aws_region" {}
variable "aws_profile" {}
variable "vpc_cidr" {}
variable "localip" {}

variable "cidrs" {
  type = "map"
}

data "aws_availability_zones" "available" {}
