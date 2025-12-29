output "waf_arn" {
    description = "WAF ARN"
    value = concat(aws_wafv2_web_acl.waf.*.arn, [""])[0]
}

output "waf_id" {
    description = "WAF ID"
    value = concat(aws_wafv2_web_acl.waf.*.id, [""])[0]
}