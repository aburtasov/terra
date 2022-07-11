// resource "aws_instence" "myweb" {}

// terraform init
// terraform import aws_instance.myweb i-09090fdy89fgh3(instance id)  ... added in terraform.tfstate
// terraform apply ... errors

resource "aws_instence" "myweb" {
    ami = "ami-*"
    instance_type = "t3.micro"

   
}

// terraform plan ... 1 add 1 destroy ... want no changes requerid

resource "aws_instence" "myweb" {
    ami = "ami-*"
    instance_type = "t3.micro"
    tags = {
        Name = "MySrv"
    }

    vpc_security_group_ids = ["sg-090fdgdfh4jf"]
    ebs_optimized = true 

   
}

resource "aws_security_group" "nomad" {
  description = "Nomad"

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0 
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    "name" = "nomad_cluster"
  }
}