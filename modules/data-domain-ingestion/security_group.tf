module "batch_compute_env_sg" {
  source = "../terraform-modules/common-modules/terraform-aws-sg"
  name = local.batch_compute_env_sg
  description = "security group for batch job compute environment"
  vpc_id = var.data_domain_vpc_id
  ingress_rules = ["all-tcp"]
  ingress_cidr_blocks =  ["${var.data_domain_vpc_cidr}"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
  tags = local.tags
}
