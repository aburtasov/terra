#---------------------------------------------------------
# My Terraform
#
# Provision Resources in Multiply AWS Regions / Accounts
#
#---------------------------------------------------------

provider "aws" {
  region = "ca-central-1"

  access_key = "adasdasf"  # если есть креды на другом аккаунте
  secret_key = "sdfsdfsfd" # если есть креды на другом аккаунте

  assume_role {
    role_arn = "arn:aws:iam::12334353454:role/RemoteAdminstrators" #amazon resource name // В этом аккаунте сделали роль и пермишинс для нас
    session_name = "my_session"
  }
}

provider "aws" {
  region = "us-east-1"
  alias = "USA"
}

provider "aws" {
  region = "eu-central-1"
  alias = "GER"
}
#=================================================================================
data "aws_ami" "default_latest_ubuntu" {
    
    owners = [ "099720109477" ]
    most_recent = true
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }
}

data "aws_ami" "usa_latest_ubuntu" {
    provider = aws.USA
    owners = [ "099720109477" ]
    most_recent = true
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }
}

data "aws_ami" "ger_latest_ubuntu" {
    provider = aws.GER
    owners = [ "099720109477" ]
    most_recent = true
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }
}

# Server in Canada region
resource "aws_instance" "my_default_server" {
  instance_type = "t3.micro"
  ami = data.aws_ami.default_latest_ubuntu.id

  tags = {
    "Name" = "Default Server"
  }
}

#provider "aws" {
 # region = "us-east-1"
#}
# Error will be here because 2 regions
#resource "aws_instance" "my_usa_server" {
 # instance_type = "t3.micro"
  #ami = "ami-*from_us_region"

  #tags = {
   # "Name" = "USA Server"
  #}
#}

resource "aws_instance" "my_usa_server" {
  provider = aws.USA
  instance_type = "t3.micro"
  ami = data.aws_ami.usa_latest_ubuntu.id #"ami-*from_us_region"

  tags = {
    "Name" = "USA Server"
  }
}

resource "aws_instance" "my_germany_server" {
  provider = aws.GER
  instance_type = "t3.micro"
  ami = data.aws_ami.ger_latest_ubuntu.id #"ami-*from_ger_region"

  tags = {
    "Name" = "Germany Server"
  }
}