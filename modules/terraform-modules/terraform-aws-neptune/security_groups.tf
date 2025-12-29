resource "aws_security_group" "this" {
  name        = "${var.cluster_identifier}-sg"
  description = "Neptune security group"
  vpc_id      = var.vpc_id

  # INGRESS
  ingress {
    description = "Inbound Neptune Traffic"
    from_port   = var.neptune_port
    to_port     = var.neptune_port
    protocol    = "tcp"
    cidr_blocks = var.neptune_subnets
  }

  ingress {
    description = "Inbound Kamino Traffic"
    from_port   = var.neptune_port
    to_port     = var.neptune_port
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  ingress {
    description = "Inbound Neptune Traffic"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = var.neptune_subnets
  }

  # EGRESS
  egress {
    description = "Outbound Neptune Traffic"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, var.neptune_security_group_tags)
}