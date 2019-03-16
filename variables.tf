variable "aws_region" {}

variable "aws_profile" {}

variable "credentials" {
  default = "/home/eon01/.aws/credentials"
}

variable "debian-ami" {
  default = "ami-023143c216b0108ea"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 80
}
