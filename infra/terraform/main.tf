module "vpc" {
  source                 = "./modules/terraform-aws-vpc"
  cidr                   = var.vpc_cidr
  name                   = "${var.name}-${var.environment}"
  nat_per_az             = true
  separate_db_subnets    = true
  subnet_outer_offsets   = [ 3,3,3 ]
  subnet_inner_offsets   = [ 1,1 ]
  transit_gateway_attach = false
  transit_gateway_id     = ""
  allow_cidrs_default    = {}
  tags = var.tags

  public_subnet_tags = var.tags

  private_subnet_tags = var.tags
  environment = var.environment
}

# write the module to create S3 buckets