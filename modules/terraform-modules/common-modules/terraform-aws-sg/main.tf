##########################
# Security group 
##########################
resource "aws_security_group" "this" {
  count = var.create && var.use_name_prefix == false ? 1 : 0
  name                   = var.name
  description            = var.description
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

###################################
# Ingress - List of rules (simple)
###################################
# Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "ingress_rules" {
  count = var.create && var.project_create ==false && length(var.ingress_rules) > 0 ? length(var.ingress_rules) : 0
  security_group_id = aws_security_group.this[0].id
  type              = "ingress"

  cidr_blocks = var.ingress_cidr_blocks

  description      = var.rules[var.ingress_rules[count.index]][3]

  from_port = var.rules[var.ingress_rules[count.index]][0]
  to_port   = var.rules[var.ingress_rules[count.index]][1]
  protocol  = var.rules[var.ingress_rules[count.index]][2]
}

# Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "ingress_rules_proj" {
  count = var.create && var.project_create == true && length(var.ingress_rules) > 0 ? length(var.ingress_rules) : 0
  security_group_id = aws_security_group.this[0].id
  type              = "ingress"

cidr_blocks = [tostring(var.ingress_cidr_blocks[count.index])]

  description      = var.rules[var.ingress_rules[count.index]][3]

  from_port = var.rules[var.ingress_rules[count.index]][0]
  to_port   = var.rules[var.ingress_rules[count.index]][1]
  protocol  = var.rules[var.ingress_rules[count.index]][2]
}

##########################
# Ingress - Maps of rules
##########################
# Security group rules with "source_security_group_id", but without "cidr_blocks" and "self"
resource "aws_security_group_rule" "ingress_with_source_security_group_id" {
  count = var.create ? length(var.ingress_with_source_security_group_id) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "ingress"

  source_security_group_id = var.ingress_with_source_security_group_id[count.index]["source_security_group_id"]
  prefix_list_ids          = var.ingress_prefix_list_ids
  description = lookup(
    var.ingress_with_source_security_group_id[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_source_security_group_id[count.index],
    "from_port",
    var.rules[lookup(
      var.ingress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.ingress_with_source_security_group_id[count.index],
    "to_port",
    var.rules[lookup(
      var.ingress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][1],
  )
  protocol = lookup(
    var.ingress_with_source_security_group_id[count.index],
    "protocol",
    var.rules[lookup(
      var.ingress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][2],
  )
}

# Security group rules with "self", but without "cidr_blocks" and "source_security_group_id"
resource "aws_security_group_rule" "ingress_with_self" {
  count = var.create ? length(var.ingress_with_self) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "ingress"

  self            = lookup(var.ingress_with_self[count.index], "self", true)
  prefix_list_ids = var.ingress_prefix_list_ids
  description = lookup(
    var.ingress_with_self[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_self[count.index],
    "from_port",
    var.rules[lookup(var.ingress_with_self[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.ingress_with_self[count.index],
    "to_port",
    var.rules[lookup(var.ingress_with_self[count.index], "rule", "_")][1],
  )
  protocol = lookup(
    var.ingress_with_self[count.index],
    "protocol",
    var.rules[lookup(var.ingress_with_self[count.index], "rule", "_")][2],
  )
}

##################################
# Egress - List of rules (simple)
##################################
# Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "egress_rules" {
  count = var.create && length(var.egress_rules) > 0  ? length(var.egress_rules) : 0
  security_group_id = aws_security_group.this[0].id
  type              = "egress"

  cidr_blocks      = var.egress_cidr_blocks
  description      = var.rules[var.egress_rules[count.index]][3]

  from_port = var.rules[var.egress_rules[count.index]][0]
  to_port   = var.rules[var.egress_rules[count.index]][1]
  protocol  = var.rules[var.egress_rules[count.index]][2]
}

#########################
# Egress - Maps of rules
#########################
# Security group rules with "source_security_group_id", but without "cidr_blocks" and "self"
resource "aws_security_group_rule" "egress_with_source_security_group_id" {
  count = var.create ? length(var.egress_with_source_security_group_id) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "egress"

  source_security_group_id = var.egress_with_source_security_group_id[count.index]["source_security_group_id"]
  prefix_list_ids          = var.egress_prefix_list_ids
  description = lookup(
    var.egress_with_source_security_group_id[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_source_security_group_id[count.index],
    "from_port",
    var.rules[lookup(
      var.egress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.egress_with_source_security_group_id[count.index],
    "to_port",
    var.rules[lookup(
      var.egress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][1],
  )
  protocol = lookup(
    var.egress_with_source_security_group_id[count.index],
    "protocol",
    var.rules[lookup(
      var.egress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][2],
  )
}

# Security group rules with "self", but without "cidr_blocks" and "source_security_group_id"
resource "aws_security_group_rule" "egress_with_self" {
  count = var.create ? length(var.egress_with_self) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "egress"

  self            = lookup(var.egress_with_self[count.index], "self", true)
  prefix_list_ids = var.egress_prefix_list_ids
  description = lookup(
    var.egress_with_self[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_self[count.index],
    "from_port",
    var.rules[lookup(var.egress_with_self[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.egress_with_self[count.index],
    "to_port",
    var.rules[lookup(var.egress_with_self[count.index], "rule", "_")][1],
  )
  protocol = lookup(
    var.egress_with_self[count.index],
    "protocol",
    var.rules[lookup(var.egress_with_self[count.index], "rule", "_")][2],
  )
}
