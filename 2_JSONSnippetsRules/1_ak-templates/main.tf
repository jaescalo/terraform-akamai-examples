# Demo #2
# Create a new property with TF by pointing to JSON Snippets 

provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

data "akamai_contract" "contract" {
  group_name = "My Group"
}

resource "akamai_cp_code" "cp_code" {
  product_id  = "prd_SPM"
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  name        = "Ion CP Code"
}

# With this block Edge Hostnames can be created or imported. This is not really in use in this example as the edge hosntames come from the TF variable files.
resource "akamai_edge_hostname" "my_edge_hostname" {
  product_id    = "prd_SPM"
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_contract.contract.group_id
  ip_behavior   = "IPV6_COMPLIANCE"
  edge_hostname = "tf-demo.edgesuite.net"
}

data "akamai_property_rules_template" "rules" {
  template_file = abspath("${path.root}/property-snippets/main.json")
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
  variables {
    name  = "comments"
    value = var.comments
    type  = "string"
  }
}

resource "akamai_property" "my_property" {
  name        = "tf-demo-property"
  product_id  = "prd_SPM"
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
  rule_format = "v2022-06-28"
  rules       = data.akamai_property_rules_template.rules.json
}

resource "akamai_property_activation" "my_activation" {
  property_id = akamai_property.my_property.id
  contact     = var.contact
  version     = akamai_property.my_property.latest_version
  network     = upper(var.network)
}