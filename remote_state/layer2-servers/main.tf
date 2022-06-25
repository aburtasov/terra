provider "aws" {
  region = "ca-central-1"
}

terraform {
  backend "s3" {
    bucket = "name_bucket"
    key = "dev/servers/terraform.tfstate" // директория создастся в бакете
    region = "us-east-1"
  }

}

#------------------------------------------------------------------------------

data "terraform_remote_state" "my_vpc" {
  backend = "s3"
  config = {
    bucket = "name_bucket"
    key = "dev/network/terraform.tfstate" 
    region = "us-east-1"
   }
}

data "aws_ami" "latest_amazon_linux" {
    owners = [ "amazon" ]
    most_recent = true

    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

#-----------------------------------------------------------------------------

resource "aws_instance" "web_server" {
  ami = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_vpc.outputs.vpc_id]
  subnet_id = data.terraform_remote_state.my_vpc.public_subnet_ids[0]
  user_data = <<EOF
  EOF

  tags = {
    "Name" = "WebServer"
  }
}

resource "aws_security_group" "webserver" {
  name = "WebServer Security Group"
  vpc_id = data.terraform_remote_state.my_vpc.outputs.vpc_id

  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [data.terraform_remote_state.my_vpc.outputs.vpc_cidr]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "name" = "web-server-sg"
    "owner" = "admin"

  }
}

output "web_sg_id" {
  value = aws_security_group.webserver.id
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

