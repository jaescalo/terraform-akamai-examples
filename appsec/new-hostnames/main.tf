data "akamai_contract" "contract" {
  group_name = var.group_name
}

// Get configuration details
data "akamai_appsec_configuration" "config" {
    name = var.appsec_config_name
}

locals {
  all_hostnames = concat(data.akamai_appsec_configuration.config.host_names, var.new_hostnames)
}

resource "akamai_appsec_configuration" "config" {
  name        = var.appsec_config_name
  description = var.appsec_config_description
  contract_id = data.akamai_contract.contract.id
  group_id    = trimprefix(data.akamai_contract.contract.group_id, "grp_")
  host_names  = local.all_hostnames
}

resource "akamai_appsec_activations" "appsec-activation-staging" {
  config_id           = akamai_appsec_configuration.config.config_id
  network             = "STAGING"
  note                = var.appsec_activation_note
  notification_emails = [ var.email ]
  version             = var.activate_appsec_on_staging ? data.akamai_appsec_configuration.config.latest_version : data.akamai_appsec_configuration.config.staging_version
}

resource "akamai_appsec_activations" "appsec-activation-production" {
  config_id           = akamai_appsec_configuration.config.config_id
  network             = "PRODUCTION"
  note                = var.appsec_activation_note
  notification_emails = [ var.email ]
  version             = var.activate_appsec_on_production ? data.akamai_appsec_configuration.config.latest_version : data.akamai_appsec_configuration.config.production_version
}
