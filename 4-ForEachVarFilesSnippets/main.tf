# Demo #4
# Create 2 new properties by using SaaS for_each based on Snippets environment variables files

provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

data "akamai_contract" "contract" {
  group_name = "My Group"
}

resource "akamai_edge_hostname" "my_edge_hostname" {
  product_id    = "prd_SPM"
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_contract.contract.group_id
  ip_behavior   = "IPV6_COMPLIANCE"
  edge_hostname = "tf-demo.edgesuite.net"
}

data "akamai_property_rules_template" "rules" {

  for_each = var.customer_env

  template_file       = abspath("${path.module}/property-snippets/main.json")
  var_definition_file = abspath("${path.module}/environments/variableDefinitions.json")
  var_values_file     = abspath("${path.module}/environments/${each.key}/variables.json")
}

resource "akamai_property" "my_property" {

  for_each = var.customer_env

  name        = "terraform-${each.key}"
  product_id  = "prd_SPM"
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  hostnames {
    cname_from             = "tf-${each.key}.host.com"
    cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
    cert_provisioning_type = "DEFAULT"
  }
  rule_format = "latest"
  rules       = data.akamai_property_rules_template.rules[each.key].json
}

resource "akamai_property_activation" "my_activation" {

  for_each = var.customer_env

  property_id = akamai_property.my_property[each.key].id
  contact     = var.contact
  version     = akamai_property.my_property[each.key].latest_version
  network     = upper(var.network)
}