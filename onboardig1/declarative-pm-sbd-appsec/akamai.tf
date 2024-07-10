# Property

module "akamai_property" {
  source                          = "./modules/property"
  group_name                      = var.group_name
  product_id                      = var.product_id
  cp_code_name                    = var.cp_code_name
  origin_hostname                 = var.origin_hostname
  edge_hostname                   = var.edge_hostname
  property_name                   = var.domain
  property_hostnames              = var.hostnames
  version_notes                   = var.version_notes
  email                           = var.email
  activate_property_on_staging    = var.activate_property_on_staging
  activate_property_on_production = var.activate_property_on_production
}

# DNS

module "akamai_edgedns" {
  source                = "./modules/edgedns"
  dns_zone              = var.domain
  ns_servers            = var.ns_servers
  soa_email             = var.soa_email
  dns_zam               = var.domain
  edge_hostname         = var.edge_hostname
  dns_hostnames         = var.hostnames
  additional_records    = var.additional_records
  challenge_validations = var.challenge_validations
  contract_id           = module.akamai_property.contract_id
  group_id              = module.akamai_property.group_id
  property_id           = module.akamai_property.property_id
  depends_on = [
    module.akamai_property
  ]
}

# Security Configuration

module "security" {
  source      = "./modules/security"
  hostnames   = var.hostnames
  name        = var.appsec_config_name
  description = var.appsec_config_description
  contract_id = module.akamai_property.contract_id
  group_name  = var.group_name
}

# Security Configuration Activation

module "activate-security" {
  source                        = "./modules/activate-security"
  name                          = var.appsec_config_name
  config_id                     = module.security.config_id
  notification_emails           = [var.email]
  note                          = var.appsec_activation_note
  activate_appsec_on_staging    = var.activate_appsec_on_staging
  activate_appsec_on_production = var.activate_appsec_on_production
  depends_on = [
    module.security
  ]
}
