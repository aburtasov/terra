terraform {
   backend "s3" {
    bucket = "bucket-projectX-terraform-state"                    // Bucket where to SAVE Terraform State
    key = "dev/vpc/applications/app2/terraform.tfstate"           // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"
   }
}

