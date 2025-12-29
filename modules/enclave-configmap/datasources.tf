data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  provider  = aws.enclave
  name      = local.name 
}

data "aws_eks_cluster_auth" "cluster" {
  provider  = aws.enclave
  name      = local.name 
}
