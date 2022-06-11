#  Variables for Prod Enviorenment
#
#---------------------------------

region = "ca-central-1"
instance_type = "t2.small"
enable_detailed_monitoring = true
allow_ports = ["80","443"]

common_tags = {
    Owner = "Me"
    Project = "Phoenix"
    Enviornment = "prod"
}