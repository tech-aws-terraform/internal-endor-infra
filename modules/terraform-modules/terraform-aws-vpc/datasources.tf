#data "aws_vpc_endpoint_service" "s3_gateway" {
#  count = var.create_vpc && var.enable_s3_endpoint ? 1 : 0
#  service = "s3"
#  filter {
#    name   = "service-type"
#    values = ["Gateway"]
#  }
#}

data "aws_vpc_endpoint_service" "s3_gateway" {
  count = var.create_vpc && var.enable_s3_endpoint ? 1 : 0

  service = "s3"
  service_type = "Gateway"
}

data "aws_prefix_list" "s3" {
  count = var.create_vpc ? 1 : 0
  prefix_list_id = aws_vpc_endpoint.s3_gateway[count.index].prefix_list_id
}