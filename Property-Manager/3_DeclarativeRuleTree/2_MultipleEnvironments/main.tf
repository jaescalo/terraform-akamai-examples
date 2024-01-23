data "akamai_contract" "contract" {
  group_name = var.group_name
}

resource "akamai_cp_code" "cp_code" {
  product_id  = var.product_id
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  name        = var.cp_code_name
}

resource "akamai_edge_hostname" "my-resource_edge_hostname" {
  product_id    = var.product_id
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_contract.contract.group_id
  ip_behavior   = var.edge_hostname_ip_behavior
  edge_hostname = var.edge_hostname
}

locals {
  # Because there are 2 data sources (one for CUSTOMER and one for NET_STORAGE origins) we evaluate 
  # the origin_parameters.type variable to determine where to pull the rule format and rules from.
  rule_format = var.origin_parameters.type == "CUSTOMER" ? data.akamai_property_rules_builder.my-origin-resource_rule_default[0].rule_format : data.akamai_property_rules_builder.my-ns-origin-resource_rule_default[0].rule_format

  rules = var.origin_parameters.type == "CUSTOMER" ? data.akamai_property_rules_builder.my-origin-resource_rule_default[0].json : data.akamai_property_rules_builder.my-ns-origin-resource_rule_default[0].json
}

resource "akamai_property" "my-resource" {
  name        = var.property_name
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  product_id  = var.product_id

  dynamic "hostnames" {
    for_each = var.property_hostnames
    content {
      cname_from             = hostnames.value
      cname_to               = akamai_edge_hostname.my-resource_edge_hostname.edge_hostname
      cert_provisioning_type = "DEFAULT"
    }
  }
  rule_format = local.rule_format
  rules       = replace(local.rules, "\"rules\"", "\"comments\": \"${var.version_notes}\", \"rules\"")
}

resource "akamai_property_activation" "my-resource-staging" {
  property_id                    = akamai_property.my-resource.id
  contact                        = var.emails
  version                        = akamai_property.my-resource.latest_version
  network                        = "STAGING"
  auto_acknowledge_rule_warnings = true
}

resource "akamai_property_activation" "my-resource-production" {
  property_id                    = akamai_property.my-resource.id
  contact                        = var.emails
  version                        = akamai_property.my-resource.latest_version
  network                        = "PRODUCTION"
  auto_acknowledge_rule_warnings = true
}