resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  role          = var.role_arn
  runtime       = var.runtime
  handler       = var.lambda_handler
  memory_size   = var.memory_size
  reserved_concurrent_executions = var.num_concurrent_executions
  timeout          = var.timeout
  description      = var.description
  tags             = var.tags
  filename         = data.archive_file.python_lambda_package.output_path
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  layers           = var.create_layer ? [aws_lambda_layer_version.lambda_layer[0].arn] : []
  lifecycle {
    ignore_changes = [source_code_hash]
  }
  environment {
    variables = var.env_vars
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  action        = var.action
  function_name = aws_lambda_function.lambda_function.arn
  principal     = var.principal
  source_arn    = var.source_arn
}

resource "aws_lambda_layer_version" "lambda_layer" {
  count               = var.create_layer ? 1 : 0
  filename            = "${path.module}/lambda_layer/${var.layer_filename}"
  layer_name          = var.layer_name
  compatible_runtimes = [var.runtime]
}

#add sqs as trigger for lambda
resource "aws_lambda_event_source_mapping" "example" {
  count            = var.create_sqs_trigger ? 1 : 0
  event_source_arn = var.sqs_queue_arn
  function_name    = aws_lambda_function.lambda_function.arn
}

resource "aws_lambda_permission" "additional_event_trigger" {
  count = var.additional_event_trigger ? length(var.additional_source_arn) : 0
  action        = var.action
  function_name = aws_lambda_function.lambda_function.arn
  principal     = var.principal
  source_arn    = var.additional_source_arn[count.index]
}