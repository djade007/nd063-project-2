provider "aws" {
  region     = "us-east-1"
}

resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Udacity Terraform VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Udacity Terraform Subnet"
  }
}

resource "aws_instance" "udacity_t2" {
  count = 4
  ami = "ami-08f3d892de259504d"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "Udacity Terraform T2 Instance"
  }
}

resource "aws_instance" "udacity_m4" {
  count = 2
  ami = "ami-08f3d892de259504d"
  instance_type = "m4.large"
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "Udacity Terraform M4 Instance"
  }
}
