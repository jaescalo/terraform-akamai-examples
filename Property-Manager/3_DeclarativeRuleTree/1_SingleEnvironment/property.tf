terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = ">= 2.0.0"
    }
  }
  required_version = ">= 0.13"
}

provider "akamai" {
  edgerc         = var.edgerc_path
  config_section = var.config_section
}

module "akamai_rule_tree" {
  source        = "./modules/rules"
  cpcode        = var.cpcode
  origin_server = var.origin_server
}

data "akamai_contract" "contract" {
  group_name = var.group_name
}

resource "akamai_edge_hostname" "jaescalo-tf-example-edgesuite-net" {
  product_id    = var.product_id
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_contract.contract.group_id
  ip_behavior   = var.ip_behavior
  edge_hostname = var.edge_hostname
}

resource "akamai_property" "jaescalo_terraform-prod" {
  name        = var.property_name
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id
  product_id  = var.product_id
  rule_format = var.rule_format
  hostnames {
    cname_from             = var.hostname
    cname_to               = akamai_edge_hostname.jaescalo-tf-example-edgesuite-net.edge_hostname
    cert_provisioning_type = var.cert_provisioning_type
  }
  rules = module.akamai_rule_tree.json_rule_tree
  depends_on = [
    module.akamai_rule_tree
  ]
}

resource "akamai_property_activation" "jaescalo_terraform-prod" {
  property_id = akamai_property.jaescalo_terraform-prod.id
  contact     = var.email_contacts
  version     = akamai_property.jaescalo_terraform-prod.latest_version
  network     = upper(var.env)
}
