provider "aws" {
  region                  = "eu-west-2"
  shared_credentials_file = "${var.credentials}"
  profile                 = "terraform"
}

resource "aws_instance" "prod" {
  ami = "${var.debian-ami}"
  instance_type = "t2.micro"
  tags {
    Name = "prod"
  }
}

resource "aws_security_group" "prod-sg" {
  name = "prod-sg"
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}