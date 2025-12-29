##########  Role ##########

resource "aws_iam_role" "iam_role" {
  name                 = var.role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = var.assume_role_policy
  tags                 = var.tags
}

########## Policy ##########
resource "aws_iam_role_policy" "iam_policy" {
    name   = var.policy_name
    role   = aws_iam_role.iam_role.id
    policy = var.policy
}

resource "aws_iam_role_policy_attachment" "attachment" {
 count = "${length(var.attach_exist_policies)}"
 role = "${aws_iam_role.iam_role.name}"
 policy_arn = "${var.attach_exist_policies[count.index]}"
}

resource "aws_iam_service_linked_role" "service_role" {
  count             = var.create_service_role
  aws_service_name  = var.aws_service_name
  description       = var.service_role_desc
}