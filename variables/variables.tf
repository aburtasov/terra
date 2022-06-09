variable "region" {
    description = "Enter AWS Region to deploy Server"
    type = string
    default = "ca-central-1"
}

variable "instance_type" {
  description = "Enter Instance Type"
  type = string
  default = "t3.micro"
}

variable "allow_ports" {
  description = "List of Ports to open for server"
  type = list
  default = ["80","443","22","8080"]
}

variable "_enable_detailed_monitoring" {
  description = "Enter Monitoring"
  type = bool
  default = "true"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type = map

  default = {
      
      Owner = "Me"
      Project = "Phoenix"
      Env = "Development"
      
  }
}
