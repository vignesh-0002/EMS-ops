variable "environment" {
  description = "Detup the environment name of the infra resource belongs to"
  type        = string
  default     = "dev"
}
variable "creation_time" {
  type = string
  description = "creation date of the instance"
  default = "test123"
}
variable "subnet_outer_offsets" {
  type        = list(number)
  default     = [ 1,1 ]
}

variable "subnet_inner_offsets" {
  type        = list(number)
  default     = [ 1, 1 ]
}

variable "nat_per_az" {
  default = false
}

locals {
  nat_count = var.nat_per_az ? length(local.subnet_list[0]) : 1
}

