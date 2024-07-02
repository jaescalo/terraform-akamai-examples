# Variables common to 2 or more modules
variable "group_name" {}
variable "edge_hostname" {}
variable "product_id" {}
variable "property_hostnames" {}

# Certificate Enrollment variables
# Global Enrollment Parameters
variable "common_name" {}
variable "secure_network" {}
variable "sni_only" {}
variable "auto_approve_warnings" {}
variable "signature_algorithm" {}
variable "renew" {}
# Administrator Contact Details
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
# Akamai Tech Contact Details
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
# CSR (Cetificate Signing Request) Details
variable "csr_country_code" {}
variable "csr_city" {}
variable "csr_organization" {}
variable "csr_organizational_unit" {}
variable "csr_state" {}
# Network Parameters
variable "disallowed_tls_versions" {}
variable "clone_dns_names" {}
variable "geography" {}
variable "ocsp_stapling" {}
variable "preferred_ciphers" {}
variable "must_have_ciphers" {}
variable "quic_enabled" {}
# Organization Details
variable "org_name" {}
variable "org_phone" {}
variable "org_address_line_one" {}
variable "org_city" {}
variable "org_country_code" {}
variable "org_postal_code" {}
variable "org_region" {}

# Edge Hostname variables
variable "ip_behavior" {}

# Property variables
variable "cp_code_name" {}
variable "property_name" {}
variable "rule_format" {}
variable "origin_hostname" {}
variable "network" {}
variable "email" {}
variable "version_notes" {}
variable "activate_property_on_staging" {}
variable "activate_property_on_production" {}

# DNS variables
variable "dns_zone" {}
variable "additional_records" {}