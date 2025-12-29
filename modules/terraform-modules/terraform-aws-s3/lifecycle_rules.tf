variable "partial_upload_cleanup_rules" {
  description = "Map of S3 Partial upload cleanup rules"
  default = [
    {
      id = "abort-incomplete-multipart-upload-lifecyle-rule"
      status = "Enabled"
      abort_incomplete_multipart_upload_days = {
        days_after_initiation = 2
      }
    }
  ]
}