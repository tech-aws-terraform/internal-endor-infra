output "peer_id" {
  description = "Value of the VPC peering ID"
  value       = concat(aws_vpc_peering_connection.peer_requester.*.id, [""])[0]
}