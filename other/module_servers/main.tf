terraform {
  required_providers {
    aws = {
        source = "hashicopr/aws"
        version = ">= 3.25.0"
        configuration_aliases = [
            aws.root,
            aws.prod,
            aws.dev
        ]
    }
  }
}


#--------------------------------------------------------------

data "aws_ami" "latest_ubuntu20_root" {
    provider = aws.root
    owners = [ "099720109477" ]
    most_recent = true
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-20.04-amd64-server-*"]
    }
}

data "aws_ami" "latest_ubuntu20_prod" {
    provider = aws.prod
    owners = [ "099720109477" ]
    most_recent = true
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }
}

data "aws_ami" "latest_ubuntu20_dev" {
    provider = aws.dev
    owners = [ "099720109477" ]
    most_recent = true
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }
}

#---------------------------------------------------------------------------------

resource "aws_instance" "webserver_root" {
  provider = aws.root
  ami = data.aws_ami.latest_ubuntu20_root.id
  instance_type = var.instance_type
 
  tags = {Name = "Server-Root"}
}

resource "aws_instance" "webserver_prod" {
  provider = aws.prod
  ami =data.aws_ami.latest_ubuntu20_prod.id
  instance_type = var.instance_type
 
  tags = {Name = "Server-Prod"}
}

resource "aws_instance" "webserver_dev" {
  provider = aws.dev
  ami =data.aws_ami.latest_ubuntu20_dev.id
  instance_type = var.instance_type

  tags = {Name = "Server-Dev"}
}