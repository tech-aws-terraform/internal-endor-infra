resource "aws_vpc_peering_connection" "peer_requester" {
  vpc_id        = var.requester_vpc_id
  peer_vpc_id   = var.accepter_vpc_id
  peer_owner_id = var.accepter_owner_id
  peer_region   = var.accepter_region
  auto_accept   = false

  tags = merge({
    "Side" = "Requester"
    },
    var.tags
  )
}

resource "aws_route" "requester_pvt_rtb" {
  route_table_id            = var.requester_pvt_rt #data.aws_route_table.proj_private_rtb.id
  destination_cidr_block    = var.accepter_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer_requester.id

  timeouts {
    create = "5m"
  }
}