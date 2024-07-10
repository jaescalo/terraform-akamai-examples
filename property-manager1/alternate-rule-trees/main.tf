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
  #product_id    = var.product_id
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_contract.contract.group_id
  ip_behavior   = var.edge_hostname_ip_behavior
  edge_hostname = var.edge_hostname
  certificate   = var.certificate
  # For some reason when the edge hostname is imported and we keep the product_id argument it thinks we want to modify it
  lifecycle {
    ignore_changes = [
      product_id,
    ]
  }
}

module "rule_tree" {
  source          = "./modules/rules"
  environment     = var.environment
  origin_hostname = var.origin_hostname
  cp_code         = parseint(replace(akamai_cp_code.cp_code.id, "cpc_", ""), 10)
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
      cert_provisioning_type = "DEFAULT"
    }
  }
  rule_format   = module.rule_tree.rule_format
  rules         = module.rule_tree.rules
  version_notes = var.version_notes
  depends_on = [
    module.rule_tree
  ]
  # Version notes depend on values that change on every commit. Ignoring notes as a valid change
  lifecycle {
    ignore_changes = [
      version_notes,
    ]
  }
}

resource "akamai_property_activation" "my_property_activation_staging" {
  property_id                    = akamai_property.my_property.id
  contact                        = [var.email]
  version                        = var.activate_property_on_staging ? akamai_property.my_property.latest_version : akamai_property.my_property.staging_version
  network                        = "STAGING"
  note                           = var.version_notes
  auto_acknowledge_rule_warnings = true

  # Activation notes depend on values that change on every commit. Ignoring notes as valid change
  lifecycle {
    ignore_changes = [
      note,
    ]
  }
}

resource "akamai_property_activation" "my_property_activation_production" {
  property_id                    = akamai_property.my_property.id
  contact                        = [var.email]
  version                        = var.activate_property_on_production ? akamai_property.my_property.latest_version : akamai_property.my_property.production_version
  network                        = "PRODUCTION"
  auto_acknowledge_rule_warnings = true
  note                           = var.version_notes

  # Activation notes depend on values that change on every commit. Ignoring notes as valid change
  lifecycle {
    ignore_changes = [
      note,
    ]
  }
  compliance_record {
    noncompliance_reason_no_production_traffic {
      ticket_id = "123"
    }
  }

}
