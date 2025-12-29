data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_dir  = "${path.module}/${var.lambda_dir}/"
  output_path = "${path.module}/lambda_function.zip"
}