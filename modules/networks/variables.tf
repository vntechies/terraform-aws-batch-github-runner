variable "default_tags" {
  description = "(Required) Default tag for AWS resource"
  default = {
    env         = "dev"
    project     = "github-runner-batch"
    github_repo = ""
    component   = "networks"
  }
}

variable "vpc" {
  default = {
    github-runner-batch = {
      route_table_setting = {}
      
      igw_config     = { igw_enable = true , rtb_name = "public_rtb" }
      vpc_cidr_block = "10.1.0.0/16"

      subnets = {
        public_subnet1 = {
          route_table_name = "public_rtb"
          cidr = "10.1.1.0/24"
          az   = "ap-southeast-1a"
          subnet_tags = {
            "public_subnet1" = "ap-southeast-1a"
            "group" = "public_subnet"
          }
        },
        public_subnet2 = {
          route_table_name = "public_rtb"
          cidr = "10.1.2.0/24"
          az   = "ap-southeast-1b"
          subnet_tags = {
            "public_subnet2" = "ap-southeast-1b"
            "group" = "public_subnet"
          }
        },
        public_subnet3 = {
          route_table_name = "public_rtb"
          cidr = "10.1.3.0/24"
          az   = "ap-southeast-1c"
          subnet_tags = {
            "public_subnet3" = "ap-southeast-1c"
            "group" = "public_subnet"
          }
        }        
      }
    }
  }
}