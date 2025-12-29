# Set common variables for the environment. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.
locals {
  global_vars      = read_terragrunt_config(find_in_parent_folders("globals.hcl"))

  devops_account_id   = "195227247767"
  infrabuildrole	  = "infrabuild-role"
  state_bucket_name   = "${local.global_vars.locals.enclave_name}-tf-state"
  lock_dynamodb_table = "${local.global_vars.locals.enclave_name}-tf-state-lock"

  platform = "kamino"
}