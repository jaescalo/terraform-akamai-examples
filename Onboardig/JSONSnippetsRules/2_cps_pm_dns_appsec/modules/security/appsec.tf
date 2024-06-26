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

resource "akamai_appsec_configuration" "config" {
  name        = var.name
  description = var.description
  contract_id = trimprefix(data.akamai_contract.contract.id, "ctr_")
  group_id    = trimprefix(data.akamai_contract.contract.group_id, "grp_")
  host_names  = var.hostnames
}

output "config_id" {
  value = akamai_appsec_configuration.config.config_id
}

resource "akamai_appsec_selected_hostnames" "hostnames" {
  config_id = akamai_appsec_configuration.config.config_id
  hostnames = var.hostnames
  mode      = "REPLACE"
}