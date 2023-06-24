resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(local.subnet_list[1])
  cidr_block              = local.subnet_list[1][count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index + var.skip_az)
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name        = "private.${var.name}"
      Environment = var.environment
    },
    var.tags,
    var.private_subnet_tags
  )
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(local.subnet_list[0])
  cidr_block              = local.subnet_list[0][count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index + var.skip_az)
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name        = "public.${var.name}"
      Environment = var.environment
    },
    var.tags,
    var.public_subnet_tags
  )
}

resource "aws_subnet" "database" {
  vpc_id                  = aws_vpc.main.id
  count                   = var.separate_db_subnets ? length(local.subnet_list[2]) : 0
  cidr_block              = local.subnet_list[2][count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index + var.skip_az)
  map_public_ip_on_launch = false

  tags = {
    Name        = "private.database.${var.name}"
    Environment = var.environment
  }
}
