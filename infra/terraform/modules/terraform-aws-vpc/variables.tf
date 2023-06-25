variable "cidr" {
  default = "10.0.0.0/16"
}

variable "name" {
  default = "Terraform"
}

variable "nat_per_az" {
  default = false
}

variable "subnet_outer_offsets" {
  type        = list(number)
  default     = [ 1, 1 ]
}

variable "subnet_inner_offsets" {
  type        = list(number)
  default     = [ 1, 1 ]
}

locals {
  nat_count = var.nat_per_az ? length(local.subnet_list[0]) : 1
}


variable "environment" {
  description = "Setup the environment name of the infra resource belongs to"
  type        = string
  default     = "dev"
}