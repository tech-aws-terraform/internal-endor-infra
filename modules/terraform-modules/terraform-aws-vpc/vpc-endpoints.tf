resource "aws_vpc_endpoint" "s3_gateway" {
  count = var.create_vpc && var.enable_s3_endpoint ? 1 : 0
  vpc_id       = aws_vpc.this[count.index].id
  service_name = data.aws_vpc_endpoint_service.s3_gateway[count.index].service_name
  #service_name = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  tags         = local.vpce_tags
}

resource "aws_vpc_endpoint" "s3_interface" {
  count = var.create_vpc && var.enable_s3_endpoint ? 1 : 0
  vpc_id            = aws_vpc.this[count.index].id
  service_name      = "com.amazonaws.s3-global.accesspoint"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [aws_security_group.this[count.index].id]
  subnet_ids          = aws_subnet.neptune_subnet.*.id
  tags                = local.vpce_tags
}