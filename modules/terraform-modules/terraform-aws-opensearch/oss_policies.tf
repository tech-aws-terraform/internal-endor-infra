locals {
  base_rules = [
    {
      ResourceType = "collection",
      Resource = [
        "collection/${var.oss_collection_name}"
      ]
    }
  ]

  dashboard_rules = var.enable_dashboard_access ? [
    {
      ResourceType = "dashboard",
      Resource = [
        "collection/${var.oss_collection_name}"
      ]
    }
  ] : []

  combined_rules = concat(local.base_rules, local.dashboard_rules)
  # oss_security_encryption_policy_name         = lower("${var.enclave_key}-${var.oss_security_encryption_policy_name}")
  # oss_security_network_policy_vpc_access_name = lower("${var.enclave_key}-${var.oss_security_network_policy_vpc_access_name}")
  # oss_data_access_policy_name                 = lower("${var.enclave_key}-${var.oss_data_access_policy_name}")
}

#Creates a encryption policy
resource "aws_opensearchserverless_security_policy" "oss_security_encryption_policy" {
  name              = var.oss_security_encryption_policy_name
  type              = "encryption"
  description       = "Encryption security policy for ${var.oss_collection_name} collections."

  policy            = jsonencode({
    "Rules": [
      {
        "Resource": [
          "collection/${var.oss_collection_name}"
        ],
        "ResourceType": "collection"
      }
     ],
  "AWSOwnedKey": true
})
}


resource "aws_opensearchserverless_security_policy" "oss_security_network_policy_vpc_access" {
  name        = var.oss_security_network_policy_vpc_access_name
  type        = "network"
  description = "VPC access"
  policy = jsonencode([{
    Description      = "VPC access to collection and Dashboards endpoint for ${var.oss_collection_name} collection",
    AllowFromPublic = false,
    SourceVPCEs     = [aws_opensearchserverless_vpc_endpoint.oss_vpc_endpoint.id],
    Rules           = local.combined_rules
  }])
}


#Creates a dataaccess policy
resource "aws_opensearchserverless_access_policy" "oss_data_access_policy" {
  name              = var.oss_data_access_policy_name
  type              = "data"
  description       = "read and write permissions"
  
  policy = jsonencode([
    {
      Rules = [
        {
          ResourceType = "index",
          Resource = [
            "index/${var.oss_collection_name}/*"
          ],
          Permission = [
            "aoss:CreateIndex",
            "aoss:DeleteIndex",
            "aoss:UpdateIndex",
            "aoss:DescribeIndex",
            "aoss:ReadDocument",
            "aoss:WriteDocument"
          ]
        },
        {
          ResourceType = "collection",
          Resource = [
            "collection/${var.oss_collection_name}"
          ],
          Permission = [
            "aoss:CreateCollectionItems",
            "aoss:DeleteCollectionItems",
            "aoss:UpdateCollectionItems",
            "aoss:DescribeCollectionItems"
            
          ]
        }
      ],
      Principal = var.principal
    }
  ])
}