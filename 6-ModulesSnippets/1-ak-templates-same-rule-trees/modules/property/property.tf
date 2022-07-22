# Demo #6

provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "terraform"
}

data "akamai_contract" "contract" {
  group_name = var.group_name
}

data "akamai_property_rules_template" "rules" {
  template_file       = abspath("../../property-snippets/main.json")
  var_definition_file = abspath("../../environments/variableDefinitions.json")
  var_values_file     = abspath("../../environments/${var.customer_env}/variables.json")
}

resource "akamai_property" "my_property" {
  name        = "terraform-${var.customer_env}"
  product_id  = var.product_id
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id

  dynamic "hostnames" {
    for_each = var.property_and_edge_hostnames

    content {
      cname_from             = hostnames.value.property_hostname
      cname_to               = hostnames.value.edge_hostname
      cert_provisioning_type = "DEFAULT"
    }
  }
  rule_format = "latest"
  rules       = data.akamai_property_rules_template.rules.json
}

resource "akamai_property_activation" "my_activation" {
  property_id = akamai_property.my_property.id
  contact     = var.contact
  version     = akamai_property.my_property.latest_version
  network     = upper(var.network)
}
