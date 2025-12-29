terraform {
  # Live modules pin exact Terraform version;
  # The latest version of Terragrunt (v0.27.0 and above) recommends Terraform 0.14.0 or above.
  required_version = ">=1.0, <1.1" #<1.1

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.51.0"
    }
    template = {
      version = "~> 2.0"
    }
  }
}
