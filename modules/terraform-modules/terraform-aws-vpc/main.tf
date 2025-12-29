locals {
  nat_gateway_count = var.single_nat_gateway ? 1 : var.one_nat_gateway_per_az ? length(var.azs) : 0
  vpc_name = var.vpc_name
  vpce_tags = merge(
    var.tags,
    var.vpc_endpoint_tags,
  )
}

######
# VPC
######
resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge({
    "Name" = lower(format("%s%s%s", local.vpc_name,"-",var.resource_names["vpc_name"]))
  },
  var.tags
  )
}

###################
# Public Subnets
###################
resource "aws_subnet" "public" {
  count             = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = merge({
    "Name" =  lower(format("%s%s%s%s", local.vpc_name, "-", var.resource_names["public_subnet_name"], upper(element(split("-", var.azs[count.index]), 2))))
  },
  var.tags,
  var.public_subnet_tags,
  )
}

###################
# Internet Gateway
###################
resource "aws_internet_gateway" "this" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = merge({
    "Name" = lower(format("%s%s%s", local.vpc_name, "-", var.resource_names["igw_name"]))
  },
  var.tags,
  var.igw_tags,
  )
}

################
# Publiс routes
################
resource "aws_route_table" "public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = merge({
    "Name" = lower(format("%s%s%s", local.vpc_name, "-", var.resource_names["pubic_rt_name"]))
  },
  var.tags,
  var.public_route_table_tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

##########################
# Route table association
##########################

resource "aws_route_table_association" "public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
}


##############
# NAT Gateway
##############
resource "aws_eip" "nat" {
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0
  domain = "vpc"
  tags = merge({
    "Name" = lower(format("%s%s%s", local.vpc_name, "-", var.resource_names["nat_eip_name"]))
  },
  var.tags,
  var.nat_eip_tags,
  )
}

resource "aws_nat_gateway" "this" {
  count         = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0
  allocation_id = element(aws_eip.nat.*.id, var.single_nat_gateway ? 0 : count.index, )
  subnet_id     = element(aws_subnet.public.*.id, var.single_nat_gateway ? 0 : count.index, )
  tags = merge({
    "Name" = lower(format("%s%s%s%s", local.vpc_name, "-", var.resource_names["nat_gateway_name"], upper(element(split("-", var.azs[count.index]), 2))))
  },
  var.tags,
  var.nat_gateway_tags,
  )
  depends_on = [aws_internet_gateway.this]
}

################################
# Neptune DB Subnets
################################
resource "aws_subnet" "neptune_subnet" {
  count             = var.create_vpc && length(var.neptune_subnets) > 0 ? length(var.neptune_subnets) : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.neptune_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = merge({
    "Name" = lower(format("%s%s%s%s", local.vpc_name, "-", var.resource_names["neptune_subnet_name"], upper(element(split("-", var.azs[count.index]), 2))))
  },
  var.tags,
  var.neptune_subnet_tags,
  )
}

#################
# Private routes
# There are as many routing tables as the number of NAT gateways
#################
resource "aws_route_table" "private" {
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 1
  vpc_id = aws_vpc.this[0].id
  tags = merge({
    "Name" = lower(format("%s%s%s", local.vpc_name, "-", var.resource_names["private_rt_name"]))
  },
  var.tags,
  var.private_route_table_tags,
  )
}

resource "aws_route" "private_nat_gateway" {
  count = var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this.*.id, count.index)

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "neptune_subnet" {
  count = var.create_vpc && length(var.neptune_subnets) > 0 ? length(var.neptune_subnets) : 0
  subnet_id = element(aws_subnet.neptune_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, var.single_nat_gateway ? 0 : count.index, )
}

resource "aws_vpc_endpoint_route_table_association" "vpc_endpoint" {
  count = var.create_vpc && length(var.neptune_subnets) > 0 ? length(var.neptune_subnets) : 0
  route_table_id  = element(aws_route_table.private.*.id, var.single_nat_gateway ? 0 : count.index, )
  vpc_endpoint_id = aws_vpc_endpoint.s3_gateway[0].id
}