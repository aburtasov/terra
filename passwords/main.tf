provider "aws" {
  region = "ca-central-1"
}

/*
variable "name" {
  default = "vasya"
} 
*/

resource "random_string" "rds_password" {
  length = 12
  special = true
  override_special = "!#$&"

  /* keepers = {
      keeper1 = var.name
      keeper2 = var.some
  } */
}

resource "aws_ssm_parameter" "rds_password" {
  name = "/prod/mysql"
  description = "master Password for RDS MySQL"
  type = "SecureString"
  value = random_string.rds_password.result
}

data "aws_ssm_parametr" "my_rds_password" {
    name = "/prod/mysql"

    depends_on = [
      aws_ssm_parameter.rds_password
    ]
}

output "rds_password" {
  value = data.aws_ssm_parametr.my_rds_password.value
}

resource "aws_db_instance" "my_db" {
  identifier           = "prod-rds"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb-prod"
  username             = "admin"
  password             =  data.aws_ssm_parametr.my_rds_password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
}