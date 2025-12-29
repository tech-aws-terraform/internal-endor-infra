data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_dir  = "${path.module}/source_code/"
  output_path = "${path.module}/lambda_function.zip"
}
