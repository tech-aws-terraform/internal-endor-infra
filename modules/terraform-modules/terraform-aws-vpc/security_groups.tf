resource "aws_security_group" "this" {
  count       = var.create_org_catalog_sg ? 1 : 0
  name        = "${var.enclave_key}-org-catalog-sg"
  description = "Org Catalog security group"
  vpc_id      = aws_vpc.this[count.index].id

  # INGRESS
  ingress {
    description = "Inbound HTTPS Traffic"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Inbound Self Reference"
    from_port = 0
    to_port = 0
    protocol = -1
    self = true
  }
  
  # EGRESS
  egress {
    description = "Outbound Traffic"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}