resource "aws_pipes_pipe" "eventbridge-pipe" {
  name       = var.pipe_name
  role_arn   = var.assume_role_arn
  source     = var.source_arn
  target     = var.target_arn

  source_parameters {
    dynamodb_stream_parameters {
      starting_position = "LATEST"
      batch_size = 1
      maximum_record_age_in_seconds = -1
      #maximum_batching_window_in_seconds = -1
      maximum_retry_attempts = -1
    }
    filter_criteria {
      filter {
        pattern = jsonencode(
          {
            "dynamodb": {
              "NewImage": {
                "groupId": {
                  "S": ["default"]
                }
              }
            }
          }
        )
      }
    }

  }

  # target_parameters {
    # step_function_state_machine_parameters {
    #   invocation_type = var.step_func_invoc_type
    # }

  #depends_on = [var.source_role_policy, var.target_role_policy]
  depends_on = [var.target_role_policy]
  lifecycle {
    ignore_changes = all
  }
}