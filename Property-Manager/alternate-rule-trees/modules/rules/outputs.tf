output "rule_format" {
  value = data.akamai_property_rules_builder.my_property_rule_default.rule_format
}

output "rules" {
  value = data.akamai_property_rules_builder.my_property_rule_default.json
}