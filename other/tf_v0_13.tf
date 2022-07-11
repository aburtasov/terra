provider "aws" {
  region = var.region
}

#============================================

module "vpc-dev" {
  source = "./modules/aws_network"
  env = "dev"
  vpc_cidr = var.vpc_settings["dev"]
}

module "vpc-staging" {
  source = "./modules/aws_network"
  env = "stag"
  vpc_cidr = var.vpc_settings["stag"]
}

module "vpc-prod" {
  source = "./modules/aws_network"
  env = "prod"
  vpc_cidr = var.vpc_settings["prod"]

  depends_on = [
    module.vpc-dev,
    module.vpc-staging
  ]
}

#============================================

module "vpc" {
    count = 2
    source = "./modules/aws_network"
    env = "demo-${count.index + 1}"
}

module "vpc_list" {
  for_each = var.vpc_settings
  source = "./modules/aws_network"
  env = each.key 
  vpc_cidr = each.value

}

#==========================================

variable "region" {
  type = string
  default = "eu-west-1"

  validation {
    condition = substr(var.region,0 ,3) == "eu-"
    error_message = "Must be an EUROPE AWS Region,like eu-" 
  }
}