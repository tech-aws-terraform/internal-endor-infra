# Creates a VPC endpoint
resource "aws_opensearchserverless_vpc_endpoint" "oss_vpc_endpoint" {
  name               = var.oss_vpc_endpoint_name
  vpc_id             = var.vpc_id
  subnet_ids         = var.private_subnet_ids
  security_group_ids = [var.vpc_security_group]
}