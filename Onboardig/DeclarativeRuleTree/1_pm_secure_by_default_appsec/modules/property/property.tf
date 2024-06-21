# Use of Modules to Deploy Property and DNS Records with the Secure by Default challenges

data "akamai_contract" "contract" {
  group_name = var.group_name
}

resource "akamai_cp_code" "cp_code" {
  product_id  = var.product_id
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  name        = var.cp_code_name
}

resource "akamai_edge_hostname" "my_edge_hostname" {
  product_id    = var.product_id
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_contract.contract.group_id
  ip_behavior   = "IPV6_COMPLIANCE"
  edge_hostname = var.edge_hostname
  certificate   = var.certificate_enrollment_id
}


resource "akamai_property" "my_property" {
  name        = var.property_name
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  product_id  = var.product_id

  dynamic "hostnames" {
    for_each = var.property_hostnames
    content {
      cname_from             = hostnames.value
      cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
      cert_provisioning_type = var.cert_provisioning_type
    }
  }

  rule_format = data.akamai_property_rules_builder.my_property_rule_default.rule_format
  rules       = data.akamai_property_rules_builder.my_property_rule_default.json
}

resource "akamai_property_activation" "my_property-staging" {
  property_id                    = akamai_property.my_property.id
  contact                        = [var.email]
  version                        = akamai_property.my_property.latest_version
  network                        = "STAGING"
  auto_acknowledge_rule_warnings = var.activate_in_staging
}

resource "akamai_property_activation" "my_property-production" {
  property_id                    = akamai_property.my_property.id
  contact                        = [var.email]
  version                        = akamai_property.my_property.latest_version
  network                        = "PRODUCTION"
  auto_acknowledge_rule_warnings = var.activate_in_production

  compliance_record {
    noncompliance_reason_no_production_traffic {
      ticket_id = "123"
    }
  }

}
