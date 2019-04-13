provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

#---- IAM ----

// S3 Access

resource "aws_iam_instance_profile" "s3_access_profile" {
  name = "s3_access"
  role = "${aws_iam_role.s3_access_role.name}"
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name = "s3_access_policy"
  role = "${aws_iam_role.s3_access_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
    ]
}
EOF
}

resource "aws_iam_role" "s3_access_role" {
  name = "s3_access_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Action": "sts:AssumeRole",
    "Principle": {
      "Service": "ec2.amazonaws.com"
  },
    "Effect": "Allow",
    "Sid": ""
    }
  ]
}
EOF
}

#---- VPC ----

resource "aws_vpc" "portfolio_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "portfolio_vpc"
  }
}

// Internet Gateway

resource "aws_internet_gateway" "portfolio_internet_gateway" {
  vpc_id = "${aws_vpc.portfolio_vpc.id}"

  tags {
    Name = "portfolio_igw"
  }
}

// Route Tables

resource "aws_route_table" "portfolio_public_rt" {
  vpc_id = "${aws_vpc.portfolio_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.portfolio_internet_gateway.id}"
  }

  tags {
    Name = "portfolio_public"
  }
}

resource "aws_default_route_table" "portfolio_private_rt" {
  default_route_table_id = "${aws_vpc.portfolio_vpc.default_route_table_id}"

  tags {
    Name = "portfolio_private"
  }
}

// Subnets

resource "aws_subnet" "portfolio_public1_subnet" {
  cidr_block              = "${var.cidrs["public1"]}"
  vpc_id                  = "${aws_vpc.portfolio_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "portfolio_public1"
  }
}

resource "aws_subnet" "portfolio_private1_subnet" {
  cidr_block              = "${var.cidrs["private1"]}"
  vpc_id                  = "${aws_vpc.portfolio_vpc.id}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "portfolio_private1"
  }
}

// Subnet Association

resource "aws_route_table_association" "portfolio_public1_assoc" {
  route_table_id = "${aws_route_table.portfolio_public_rt.id}"
  subnet_id      = "${aws_subnet.portfolio_public1_subnet.id}"
}

resource "aws_route_table_association" "portfolio_private1_assoc" {
  route_table_id = "${aws_default_route_table.portfolio_private_rt.id}"
  subnet_id      = "${aws_subnet.portfolio_private1_subnet.id }"
}

// Security Groups


resource "aws_security_group" "portfolio_dev_sg" {
  name = "portfolio_dev_sg"
  description = "Used for access to the dev instance"
  vpc_id = "${aws_vpc.portfolio_vpc.id}"


  # ssh
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["${var.localip}"]
  }

  # http
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["${var.localip}"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "portfolio_public_sg" {
  name = "portfolio_public_sg"
  description = "Used for the elastic load balancer for public access."
  vpc_id = "${aws_vpc.portfolio_vpc.id}"

  # http
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "portfolio_private_sg" {
  name = "portfolio_private_sg"
  description = "Used for private instances"
  vpc_id = "${aws_vpc.portfolio_vpc.id}"

  # access from vpc
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


































