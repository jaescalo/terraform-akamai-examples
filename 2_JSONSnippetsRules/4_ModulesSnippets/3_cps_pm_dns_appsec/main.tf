terraform {
  required_providers {
    akamai = {
      source = "akamai/akamai"
    }
  }
  required_version = ">= 0.13"
}

provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

module "certificate" {
  source = "./modules/certificate"
  # Global Enrollment Parameters
  renew                 = var.renew
  group_name            = var.group_name
  common_name           = var.common_name
  secure_network        = var.secure_network
  sni_only              = var.sni_only
  auto_approve_warnings = var.auto_approve_warnings
  signature_algorithm   = var.signature_algorithm
  # Administrator Contact Details
  admin_first_name       = var.admin_first_name
  admin_last_name        = var.admin_last_name
  admin_phone            = var.admin_phone
  admin_email            = var.admin_email
  admin_address_line_one = var.admin_address_line_one
  admin_city             = var.admin_city
  admin_country_code     = var.admin_country_code
  admin_organization     = var.admin_organization
  admin_postal_code      = var.admin_postal_code
  admin_region           = var.admin_region
  admin_title            = var.admin_title
  # Akamai Tech Contact Details
  tech_first_name       = var.tech_first_name
  tech_last_name        = var.tech_last_name
  tech_phone            = var.tech_phone
  tech_email            = var.tech_email
  tech_address_line_one = var.tech_address_line_one
  tech_city             = var.tech_city
  tech_country_code     = var.tech_country_code
  tech_organization     = var.tech_organization
  tech_postal_code      = var.tech_postal_code
  tech_region           = var.tech_region
  tech_title            = var.tech_title
  # CSR (Cetificate Signing Request) Details
  csr_country_code        = var.csr_country_code
  csr_city                = var.csr_city
  csr_organization        = var.csr_organization
  csr_organizational_unit = var.csr_organizational_unit
  csr_state               = var.csr_state
  # Network Parameters
  disallowed_tls_versions = var.disallowed_tls_versions
  clone_dns_names         = var.clone_dns_names
  geography               = var.geography
  ocsp_stapling           = var.ocsp_stapling
  preferred_ciphers       = var.preferred_ciphers
  must_have_ciphers       = var.must_have_ciphers
  quic_enabled            = var.quic_enabled
  # Organization Details
  org_name             = var.org_name
  org_phone            = var.org_phone
  org_address_line_one = var.org_address_line_one
  org_city             = var.org_city
  org_country_code     = var.org_country_code
  org_postal_code      = var.org_postal_code
  org_region           = var.org_region
}

module "edge_hostname" {
  source        = "./modules/edge_hostname"
  product_id    = var.product_id
  group_name    = var.group_name
  edge_hostname = var.edge_hostname
  ip_behavior   = var.ip_behavior
  certificate   = module.certificate.enrollment_id
  depends_on = [
    module.certificate
  ]
}

module "akamai_property" {
  source            = "./modules/property"
  group_name        = var.group_name
  product_id        = var.product_id
  cp_code_name      = var.cp_code_name
  edge_hostname     = var.edge_hostname
  property_name     = var.property_name
  rule_format       = var.rule_format
  property_hostname = var.property_hostname
  origin            = var.origin
  network           = var.network
  email             = var.email
  depends_on = [
    module.edge_hostname
  ]
}

module "akamai_edgedns_records" {
  source            = "./modules/dns"
  dns_zone          = var.dns_zone
  edge_hostname     = var.edge_hostname
  property_hostname = var.property_hostname
  depends_on = [
    module.akamai_property
  ]
}

module "security" {
  source      = "./modules/security"
  hostnames   = [var.property_hostname]
  name        = var.appsec_config_name
  description = var.description
  group_name  = var.group_name
  security_policy_name   = var.security_policy_name
  security_policy_prefix = var.security_policy_prefix
  depends_on = [
    module.akamai_property
  ]
}

# Makes sense to put the activation step in a separate module instead of chaining dependencies for the activation
module "activate-security" {
  source              = "./modules/activate-security"
  name                = var.appsec_config_name
  config_id           = module.security.config_id
  network             = var.appsec_network
  notification_emails = var.notification_emails
  note                = var.note
  depends_on = [
    module.security
  ]
}
