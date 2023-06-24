locals {
  lcreation_time = timestamp()
  lcreation_time_formated = formatdate("YYYYMMDDhhmmss", timestamp())
}

# local variables that is used to make the subnet segregation from the CIDR provided
locals {
  allow_cidrs_default = merge(var.allow_cidrs_default, { self = aws_vpc.main.cidr_block})
  subnet_list         = [ for cidr_block in cidrsubnets(var.cidr, var.subnet_outer_offsets...) : cidrsubnets(cidr_block, var.subnet_inner_offsets...) ]
  # subnet segregation example: https://developer.hashicorp.com/terraform/language/functions/cidrsubnets
}