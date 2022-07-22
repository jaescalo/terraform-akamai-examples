# Demo #5
# Create 2 new properties by using TF Workspaces based on Snippets environment variables files

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
  template_file       = abspath("${path.module}/property-snippets/main.json")
  var_definition_file = abspath("${path.root}/environments/variableDefinitions.json")
  var_values_file     = abspath("${path.root}/environments/${var.customer_env[terraform.workspace]}/variables.json")
}

resource "akamai_property" "my_property" {
  name        = "terraform-${var.customer_env[terraform.workspace]}"
  product_id  = "prd_SPM"
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  hostnames {
    cname_from             = "tf-${var.customer_env[terraform.workspace]}.host.com"
    cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
    cert_provisioning_type = "DEFAULT"
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
