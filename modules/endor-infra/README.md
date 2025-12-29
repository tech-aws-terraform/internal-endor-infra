# Variables for testing infra

- enclave_key    = "enclave-demo"
- enclave_region = "eu-central-1"
- platform       = "kamino"
- environment    = "dev"

**IAM Variables**
- endor_account_id    = "381492263753"
- enclave_engg_role 	= "Roche/Products/KAMINO/KAMINOENCLAVEEngineering"
- enclave_devops_role	= "enclave-demo-eks-service-account-role"

<!--
# enclave_trust_iam_roles = ["arn:aws:iam::058264342729:role/enclave-demo-eks-service-account-role", "arn:aws:iam::058264342729:role/Roche/Products/KAMINO/KAMINOENCLAVEEngineering"]
-->

**Glue Variables**
- transfer_glue_script_location      = "s3://dev-euc1-kamino-dev-serverless-s3/glue/transfer_function.py"
- approval_glue_script_location      = "s3://dev-euc1-kamino-dev-serverless-s3/glue/approval_glue_function.py"
- ingest_glue_script_location        = "s3://dev-euc1-kamino-dev-serverless-s3/glue/ingest_glue_function.py"
- azs                                = ["eu-central-1a", "eu-central-1b"]

**SQS Variables**
- enclave_account_id  = "058264342729"

<!--
# S3 Buckets
# s3_cors_origins                 = ["https://enclave-demo.kamino-dev.platform.navify.com", "https://api.enclave-demo.kamino-dev.platform.navify.com"]
# enclave_root_iam_role           = ["arn:aws:iam::058264342729:root"]
-->
<!--
**AppSync Variables**
# api_key_expires                 = "2024-10-15T04:00:00Z"
-->

**Api Gateway Variables**
- api_gw_stage_name               = "dev"

**Org Catalog and Neptune Variables** 
- accepter_cidr    = "192.168.2.0/24"
- accepter_vpc_id  = "vpc-0af658f181661ca16"

- cidr                                = "172.16.104.0/24"
- public_subnets                      = ["172.16.104.0/26", "172.16.104.64/26"]
- neptune_subnets                     = ["172.16.104.128/26", "172.16.104.192/26"]

[comment] delete_protection set as false for local testing. Set to true otherwise
- deletion_protection = false
- enclave_domain_name = "enclave-demo.kamino-dev.platform.navify.com"

- iam_database_authentication_enabled = true
- instance_count                      = 3
- min_nep_capacity                    = 4
- max_nep_capacity                    = 8

- enclave_base_vpc_cidr               = ["192.168.2.0/24"]          