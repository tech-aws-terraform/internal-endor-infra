output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.this.*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.this.*.arn, [""])[0]
}

output "vpc_cidr" {
  description = "The CIDR of the VPC"
  value       = concat(aws_vpc.this.*.cidr_block, [""])[0]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public.*.arn
}

output "neptune_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.neptune_subnet.*.id
}

output "def_rtb_id" {
  description = "VPC default route table ID"
  value       = concat(aws_vpc.this.*.default_route_table_id, [""])[0]
}

output "public_rtb_id" {
  description = "VPC default route table ID"
  value       = concat(aws_route_table.public.*.id, [""])[0]
}

output "private_rtb_id" {
  description = "VPC default route table ID"
  value       = concat(aws_route_table.private.*.id, [""])[0]
}

output "prefix_list_id" {
  description = "Managed Prefix List IDs"
  value = data.aws_prefix_list.s3[0].prefix_list_id
}

output "s3_gateway_service_id" {
  description = "S3 Gateway Endpoint Service ID"
  value = aws_vpc_endpoint.s3_gateway[0].id
}

output "s3_gateway_service_name" {
  description = "S3 Gateway Endpoint Service Name"
  value = data.aws_vpc_endpoint_service.s3_gateway[0].service_name
}

output "s3_interface_service_id" {
  description = "S3 Interface Endpoint Service ID"
  value = aws_vpc_endpoint.s3_interface[0].id
}

/*output "s3_interface_service_name" {
  description = "S3 Interface Endpoint Service Name"
  value = data.aws_vpc_endpoint_service.s3_interface[0].service_name
}*/

output "org_vpc_https_sg" {
  description = "Org VPC Security Group"
  value       = aws_security_group.this[0].id
}