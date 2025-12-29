# Set common variables for the environment. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.
locals {
  global_vars      = read_terragrunt_config(find_in_parent_folders("globals.hcl"))

  devops_account_id   = "195227247767"
  infrabuildrole	  = "infrabuild-role"
  state_bucket_name   = "${local.global_vars.locals.enclave_name}-tf-state"
  lock_dynamodb_table = "${local.global_vars.locals.enclave_name}-tf-state-lock"

  platform = "kamino"

  # transfer_glue_script_location      = "s3://internal-enclave-lambda-build-artifact/glue/<tag_version>/transfer_function.py"
  # approval_glue_script_location      = "s3://internal-enclave-lambda-build-artifact/glue/<tag_version>/approval_glue_function.py"
  # ingest_glue_script_location        = "s3://internal-enclave-lambda-build-artifact/glue/<tag_version>/ingest_glue_function.py"
  img_glue_script_location           = "s3://internal-enclave-lambda-build-artifact/glue/<tag_version>/thumbnail_img_creation.py"

  org_cat_fm_glue_script_location             = "s3://internal-enclave-lambda-build-artifact/glue/<tag_version>/shared_file_movement_function.py"
  org_cat_data_access_fm_glue_script_location = "s3://internal-enclave-lambda-build-artifact/glue/<tag_version>/data_access_file_movement_function.py"
  org_cat_download_glue_script_location       = "s3://internal-enclave-lambda-build-artifact/glue/<tag_version>/download_file_function.py"

  # Enclave Specific Resources
  enclave_specific_ingest_glue_script_location = "s3://internal-enclave-lambda-build-artifact/glue/<tag_version>/replication_ingest_glue.py"
}