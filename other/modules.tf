provider "aws" { // Root Account
  region = "us-west-2"
}

provider "aws" { // DEV Account
  region = "us-west-1"
  alias = "dev"

  assume_role {
    role_arn = "arn:aws:iam:65464564545:role/TerraformRole"
  }
}

provider "aws" { // PROD Account
  region = "ca-central-1"
  alias = "prod"

  assume_role {
    role_arn = "arn:aws:iam:03434561249:role/TerraformRole"
  }
}

#--------------------------------------------------------------

module "servers" {
  source = "./module_servers/"
  instance_type = "t3.small"

  providers = {
    aws = aws
    aws.prod = aws.prod
    aws.dev = aws.dev
   }
}