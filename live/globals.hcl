locals {
	environment					  = "" #Environment name like dev, qa, stg
	enclave_name            	  = ""
	enclave_account_id			  = ""
	endor_account_id			  = ""
	enclave_domain_name			  = "" #enclave-demo.kamino-dev.platform.navify.com
	enclave_engg_role 	  		  = "" #"Roche/Products/KAMINO/KAMINOENCLAVEEngineering"
	enclave_devops_role			  = "" #"enclave-demo-eks-service-account-role"
	api_key_expires				  = ""
	enclave_vpc_id				  = "" #enclave base VPC ID
	enclave_vpc_cidr			  = "" #enclave base VPC CIDR
	enclave_specific_resource	  = "" #False if use_endor_data_domain is true (For Internal Enclave) otherwise (True based on need)
	neptune_instance_count		  = "" #count base on dev,qa,stg and prod
	min_nep_capacity			  = "" #min neptune capacity
	max_nep_capacity			  = "" #max neptune capacity
	create_image_infra			  = "" #True to create thumbnail image infra
	create_org_catalog			  = "" #True to create org catalog - Neptune DB
	create_pagination_infra		  = "" #True to create pagination image infra
	
	## cost dash board changes
	enable_cur_report			  = "" #True or False based on need
	cost_bucket_replication		  = "" #True or False based on need
	platform_account_cost_bucket  = ""
	platform_account_id			  = ""
	enable_budget				  = "" #True or False based on need

	##Endor Data Domain Ingestion
	use_endor_data_domain			= "" #True to use endor data domain for ingestion
	endor_api_base_url = "" #Endor API BASE URL
	data_domain_vpc_id = "" # Endor Data domain VPC ID
	data_domain_vpc_cidr = "" #Endor Data Domain VPC CIDR
	data_domain_subnet_id = "" #Endor Data Domain Subnet ID (APPServer)
	batch_job_ecr_image_tag = "" #batch job docker image tag in the devops account
	data_domain_ingest_bucket = "" #Endor Data Domain ingest bucket
	endor_catalog_table_name  = "" #Endor Catalog table name
	datasync_crossaccount_role = "" #Datasync role for cross account
}
