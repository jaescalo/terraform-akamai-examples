variable "group_name" {}

# General Certificate Parameters
variable "renew" {}
variable "common_name" {}
variable "secure_network" {}
variable "sni_only" {}
variable "auto_approve_warnings" {}
variable "signature_algorithm" {}

# Admin Contact Info
variable "admin_first_name" {}
variable "admin_last_name" {}
variable "admin_phone" {}
variable "admin_email" {}
variable "admin_address_line_one" {}
variable "admin_city" {}
variable "admin_country_code" {}
variable "admin_organization" {}
variable "admin_postal_code" {}
variable "admin_region" {}
variable "admin_title" {}

# Tech Contact Info
variable "tech_first_name" {}
variable "tech_last_name" {}
variable "tech_phone" {}
variable "tech_email" {}
variable "tech_address_line_one" {}
variable "tech_city" {}
variable "tech_country_code" {}
variable "tech_organization" {}
variable "tech_postal_code" {}
variable "tech_region" {}
variable "tech_title" {}

# Info for the CSR (Certificate Signing Request)
variable "csr_country_code" {}
variable "csr_city" {}
variable "csr_organization" {}
variable "csr_organizational_unit" {}
variable "csr_state" {}

# Certificate Network Parameters
variable "disallowed_tls_versions" {}
variable "clone_dns_names" {}
variable "geography" {}
variable "ocsp_stapling" {}
variable "preferred_ciphers" {}
variable "must_have_ciphers" {}
variable "quic_enabled" {}

# Certificate Organization Parameters 
variable "org_name" {}
variable "org_phone" {}
variable "org_address_line_one" {}
variable "org_city" {}
variable "org_country_code" {}
variable "org_postal_code" {}
variable "org_region" {}
