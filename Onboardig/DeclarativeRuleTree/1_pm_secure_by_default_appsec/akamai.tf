provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

locals {
  global_name   = "tf.host.com"
  edge_hostname = "tf.host.com.edgesuite.net"
  hostnames     = ["tf.host.com", "tf-demo.host.com"]
  email         = "noreply@example.com"
}

module "akamai_property" {
  source             = "./modules/property"
  group_name         = "My Group"
  product_id         = "prd_Fresca"
  cp_code_name       = "tf-demo.host.com"
  edge_hostname      = local.edge_hostname
  property_name      = local.global_name
  property_hostnames = local.hostnames
  email              = local.email
  origin_server      = "origin-tf.aiqbal.com"
  certificate_enrollment_id = 123456
  cert_provisioning_type = "CPS_MANAGED"
  activate_in_staging = true
  activate_in_production = false
}

module "akamai_edgedns_records" {
  source        = "./modules/edgedns"
  dns_zone      = local.global_name
  dns_zam       = local.global_name
  edge_hostname = local.edge_hostname
  dns_hostnames = local.hostnames
  contract_id   = module.akamai_property.contract_id
  group_id      = module.akamai_property.group_id
  property_id   = module.akamai_property.property_id
  email         = local.email
  depends_on = [
    module.akamai_property
  ]
}

module "security" {
  source      = "./modules/security"
  hostnames   = local.hostnames
  name        = "tf-demo-appsec-configuration"
  description = "Spin up configuration via Terraform"
  contract_id = trimprefix(module.akamai_property.contract_id, "ctr_")
  group_name  = "My Group"
  depends_on = [
    module.akamai_property
  ]
}

module "activate-security" {
  source              = "./modules/activate-security"
  name                = "tf-demo-appsec-configuration"
  config_id           = module.security.config_id
  network             = "STAGING"
  notification_emails = [local.email]
  note                = "AppSec configuration deployed with the Akamai Terraform Provider."
  depends_on = [
    module.security
  ]
}
