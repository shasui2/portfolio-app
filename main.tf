provider "aws" {
  region                  = "${var.aws_region}"
  profile                 = "${var.aws_profile}"
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
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true

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
    Name ="portfolio_private"
  }
}


// Subnets

resource "aws_subnet" "portfolio_public1_subnet" {
  cidr_block = "${var.cidrs["public1"]}"
  vpc_id = "${aws_vpc.portfolio_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "portfolio_public1"
  }
}

resource "aws_subnet" "portfolio_private1_subnet" {
  cidr_block = "${var.cidrs["private1"]}"
  vpc_id = "${aws_vpc.portfolio_vpc.id}"
  map_public_ip_on_launch = false
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "portfolio_private1"
  }
}









































