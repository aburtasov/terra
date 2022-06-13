#-----------------------------------------------
# My Terraform
#
# Terraform Loops: Count and For if
#
#-----------------------------------------------

provider "aws" {
  region = "ca-central-1"
}

resource "aws_iam_user" "user1" {
  name = "pushkin"
}

/*
resource "aws_iam_user" "user2" {
  name = "vasya"
}

resource "aws_iam_user" "user3" {
  name = "petya"
}
*/

variable "aws_users" {
  description = "List of IAM users to create"
  default = ["Vasya","Petya","Lena","Masha","Vova"]
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name = element(var.aws_users, count.index)
}

#-----------------------------------------------------

resource "aws_instance" "servers" {
  count = 3
  ami = "ami-*"
  instance_type = "t3.micro"

  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}

#------------------------------------------------------

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name = element(var.aws_users, count.index)
}

output "created_iam_users_all" {
    value = aws_iam_user.users
}

output "created_iam_users_ids" {
  value = aws_iam_users.users[*].id
}

output "created_iam_users_custom" {
  value = [
      for user in aws_iam_user.users:
      "Username:  ${user.name} has ARN: ${user.arn}"
      
  ]
}

output "created_iam_users_map" {
  value = {
      for user in aws_iam_user.users:
      user.unique_id => user.id   
  }
}

output "custom_if_length" {
    value = {
        for x in aws_iam_user.users:
        x.name
        if length(x.name) == 4
        
    }
}

output "server_all" {
  // value = aws_instance.servers[*].id

  value = {
      for server in aws_instance.servers:
      server.id => server.public_ip

  }
}