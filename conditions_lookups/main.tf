#----------------------------------
# My Terraform
#
# Terraform Conditions and Lookups
#
#----------------------------------

provider "aws" {
  region = "eu-central-1"
}

// Map for Lookup
variable "ec2_size" {
  default = {
      "prod" = "t3.large"
      "dev" = "t3.micro"
      "staging" = "t3.small"
  }
}

// Map for Lookup
variable "allow_port_list" {
  default = {
      "prod" = ["80","443"]
      "dev" = ["80","443","8080","22"]
  }
}

variable "env" {
  default = "prod"
  //default = "dev"
}

variable "prod_owner" {
  default = "Me"
}

variable "noprod_owner" {
  default = "Some"
}

resource "aws_instance" "myserver1" {
  ami = "ami-*"
  //instance_type = var.env == "prod" ? "t2.large" : "t2.micro"
  instance_type = var.env == "prod" ? var.ec2_size["prod"] : var.ec2_size["dev"]

  tags = {
      Name = "${var.env}-server1"
      Owner = var.env == "prod"? var.prod_owner : var.noprod_owner
  }
}


resource "aws_instance" "my_dev_bastion" {
  count = var.env == "dev" ? 1 : 0
  ami = "ami-*"
  instance_type = "t2.micro"

  tags = {
      Name = "Bastion Server for Dev"
      
  }
}

// Lookup
resource "aws_instance" "myserver2" {
  ami = "ami-*"
  instance_type = lookup(var.ec2_size, var.env)

  tags = {
      Name = "${var.env}-server2"
      Owner = var.env == "prod"? var.prod_owner : var.noprod_owner
  }
}

// Lookup
resource "aws_security_group" "web" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
      for_each = lookup(var.allow_port_list,var.env)
      content {
          from_port = ingress.value
          to_port = ingress.value
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "Dynamic Security Group"
    Owner = "Me"
  }
}

