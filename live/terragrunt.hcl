locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  global_vars      = read_terragrunt_config(find_in_parent_folders("globals.hcl"))
  tag_switches     = read_terragrunt_config(find_in_parent_folders("tag_switches.hcl", "i-dont-exist.hcl"), { locals = {exclude_global_tag = "false"}})

  # Extract the variables we need for easy access
  environment             = local.global_vars.locals.environment
  account_id              = local.global_vars.locals.endor_account_id
  enclave_account_id      = local.global_vars.locals.enclave_account_id
  aws_region              = local.region_vars.locals.aws_region
  infrabuildrole          = local.environment_vars.locals.infrabuildrole
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
%{ if local.tag_switches.locals.exclude_global_tag == "false" }
provider "aws" {
  region = "${local.aws_region}"
  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id}:role/${local.infrabuildrole}"
    session_name = "INFRA_BUILD"
  }
  default_tags {
      tags = {
        Environment = "${local.environment}"
        Platform    = "kamino"
        Terraform   = "true"
      }
  }
}
%{ endif }

%{ if local.tag_switches.locals.exclude_global_tag == "true" }
provider "aws" {
  region = "${local.aws_region}"
  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id}:role/${local.infrabuildrole}"
    session_name = "INFRA_BUILD"
  }
}
%{ endif }

# Assume the role to retrieve secrets
provider "aws" {
  alias  = "secrets"
  region = "eu-central-1"
  assume_role {
    role_arn     = "arn:aws:iam::195227247767:role/InfraBuildRole"
    session_name = "GET_SECRETS"
  }
}

# Assume the role for enclave account
provider "aws" {
  alias  = "enclave"
  region = "${local.aws_region}"
  assume_role {
    role_arn     = "arn:aws:iam::${local.enclave_account_id}:role/${local.infrabuildrole}"
    session_name = "ENCLAVE_INFRA_BUILD"
  }
}

# Assume the role for primary region
provider "aws" {
  alias  = "global_region"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id}:role/${local.infrabuildrole}"
    session_name = "INFRA_BUILD"
  }
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt               = true
    bucket                = "${local.environment_vars.locals.state_bucket_name}"
    key                   = "${path_relative_to_include()}/terraform.tfstate"
    region                = "eu-central-1"
    dynamodb_table        = "${local.environment_vars.locals.lock_dynamodb_table}"
    disable_bucket_update = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.environment_vars.locals,
  local.region_vars.locals,
  local.global_vars.locals
)