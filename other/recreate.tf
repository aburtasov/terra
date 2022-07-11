provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "node1" {
  ami = "ami-*"
  instance_type = "t3.micro"

  tags = {
    Name = "Node-1"
    Owner = "Me"
  }
}

resource "aws_instance" "node2" {
  ami = "ami-*"
  instance_type = "t3.micro"

  tags = {
    Name = "Node-2"
    Owner = "Me"
  }
}

resource "aws_instance" "node3" {
  ami = "ami-*"
  instance_type = "t3.micro"

  tags = {
    Name = "Node-3"
    Owner = "Me"
  }

  depends_on = [
    aws_instance.node2
  ]
}

// пересоздать node1 ... можно с помощью комментирования ресурса
// кроме depends_on 

// terraform taint aws_instance.node2  до версии v0.15.2 
// terraform plan

// terraform --version
// terraform apply -replace aws_instance.node2 