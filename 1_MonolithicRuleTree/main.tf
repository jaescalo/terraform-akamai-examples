# Demo #1
# Create a new property with TF by pointing to a rule tree JSON file.

provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

locals {
  group_name = "My Group"
  product_id = "prd_SPM"
}

data "akamai_contract" "contract" {
  group_name = local.group_name
}

data "akamai_group" "group" {
  group_name  = local.group_name
  contract_id = data.akamai_contract.contract.id
}

resource "akamai_edge_hostname" "my_edge_hostname" {
  product_id    = local.product_id
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_contract.contract.group_id
  ip_behavior   = "IPV6_COMPLIANCE"
  edge_hostname = "tf-demo.edgesuite.net"
}

data "local_file" "rules" {
  filename = "${path.root}/terraform-demo.v1.rule-tree.json"
}

resource "akamai_property" "my_property" {
  name        = "tf-demo-property"
  product_id  = local.product_id
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  hostnames {
    cname_from             = "tf-demo.host1.com"
    cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
    cert_provisioning_type = "DEFAULT"
  }
  hostnames {
    cname_from             = "tf-demo.host2.com"
    cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
    cert_provisioning_type = "DEFAULT"
  }
  # It is always a good practice to freeze the rule tree to a specific version to prevent possible errors due to new features on newer versions of Property Manager
  rule_format = "v2022-06-28"
  rules       = data.local_file.rules.content
}

resource "akamai_property_activation" "my_activation" {
  property_id = akamai_property.my_property.id
  contact     = var.contact
  version     = akamai_property.my_property.latest_version
  network     = upper(var.network)
}
