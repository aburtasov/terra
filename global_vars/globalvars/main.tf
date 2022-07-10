provider "aws" {
  region = "ca-central-1"
}

terraform {
  backend "s3" {
    backet = "my_project_terraform"
    key = "globalvars/terraform.tfstate"
    region = "us-east-1"
  }
}

#---------------------------------------------
output "company_name" {
  value = "Company Soft Int."
}

output "owner" {
  value = "Me"
}

output "tags" {
  value = {
    project = "Assembly"
    CostCenter = "R&D"
    Country = "Canada"
  }
}

