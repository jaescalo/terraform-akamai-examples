terraform {
  required_providers {
    akamai = {
      source = "akamai/akamai"
      version = "= 5.5.0"
    }
  }
}

data "akamai_contract" "contract" {
  group_name = var.group_name
}

resource "akamai_cp_code" "cp_code" {
  product_id  = var.product_id
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  name        = var.cp_code_name
}

data "akamai_property_rules_template" "rules" {
  template_file = abspath("${path.module}/property-snippets/main.json")
  variables {
    name  = "cpcode"
    value = parseint(replace(akamai_cp_code.cp_code.id, "cpc_", ""), 10)
    type  = "number"
  }
  variables {
    name  = "origin"
    value = var.origin
    type  = "string"
  }
}

resource "akamai_property" "my_property" {
  name        = var.property_name
  product_id  = var.product_id
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id

  hostnames {
      cname_from             = var.property_hostname
      cname_to               = var.edge_hostname
      cert_provisioning_type = "CPS_MANAGED"
  }

  rule_format = var.rule_format
  rules       = data.akamai_property_rules_template.rules.json
}

resource "akamai_property_activation" "my_activation" {
  property_id = akamai_property.my_property.id
  network     = var.network
  version     = akamai_property.my_property.latest_version
  contact     = [ var.email ]
}
