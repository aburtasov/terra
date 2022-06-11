#-------------------------------------- 
#Auto Fill parameters for DEV
#
# File can be names as:
# - terraform.tfvars
# - *.auto.tfvars (example:prod.auto.tfvars, dev.auto.tfvars, etc.)
#---------------------------------------

region = "ca-central-1"
instance_type = "t2.micro"
enable_detailed_monitoring = false
allow_ports = ["80","443","22","8080"]

common_tags = {
    Owner = "Me"
    Project = "Phoenix"
    Enviornment = "dev"
}