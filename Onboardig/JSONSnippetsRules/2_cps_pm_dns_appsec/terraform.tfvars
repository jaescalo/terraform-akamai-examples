# Variables common to 2 or more modules
group_name        = "My Group"
edge_hostname     = "tf-demo.host.com.edgekey.net"
product_id        = "Fresca"
property_hostname = "tf-demo.host.com"

# Certificate Enrollment variables
# Global Enrollment Parameters
renew          = true
common_name    = "*.example.com"
secure_network = "enhanced-tls"
sni_only       = true
auto_approve_warnings = [
  "DNS_NAME_LONGER_THEN_255_CHARS",
  "CERTIFICATE_EXPIRATION_DATE_BEYOND_MAX_DAYS",
  "TRUST_CHAIN_EMPTY_AND_CERTIFICATE_SIGNED_BY_NON_STANDARD_ROOT"
]
signature_algorithm = "SHA-256"
# Administrator Contact Details
admin_first_name       = "Mario"
admin_last_name        = "Rossi"
admin_phone            = "+1-311-555-2368"
admin_email            = "mrossi@example.com"
admin_address_line_one = "admin_150Broadway"
admin_city             = "Cambridge"
admin_country_code     = "US"
admin_organization     = "admin_ExampleCorp."
admin_postal_code      = "02142"
admin_region           = "MA"
admin_title            = "Administrator"
# Akamai Tech Contact Details
tech_first_name       = "Juan"
tech_last_name        = "Perez"
tech_phone            = "+1-311-555-2369"
tech_email            = "juanperez@akamai.com"
tech_address_line_one = "tech_150Broadway"
tech_city             = "Cambridge"
tech_country_code     = "US"
tech_organization     = "tech_ExampleCorp."
tech_postal_code      = "02142"
tech_region           = "MA"
tech_title            = "Administrator"
# CSR (Cetificate Signing Request) Details
csr_country_code        = "US"
csr_city                = "Cambridge"
csr_organization        = "csr_ExampleCorp."
csr_organizational_unit = "csr_CorpIT"
csr_state               = "MA"
# Network Parameters
disallowed_tls_versions = ["TLSv1", "TLSv1_1"]
clone_dns_names         = false
geography               = "core"
ocsp_stapling           = "on"
preferred_ciphers       = "ak-akamai-2020q1"
must_have_ciphers       = "ak-akamai-2020q1"
quic_enabled            = false
# Organization Details
org_name             = "org_ExampleCorp."
org_phone            = "+1-311-555-2370"
org_address_line_one = "org_150Broadway"
org_city             = "Cambridge"
org_country_code     = "US"
org_postal_code      = "02142"
org_region           = "MA"

# Edge Hostname variables
ip_behavior = "IPV4"

# Property variables
cp_code_name  = "tf-demo.host.com"
property_name = "tf-demo.host.com"
rule_format   = "v2023-01-05" 
origin        = "origin.tf-demo.host.com"
network       = "staging"
email         = "juanperez@akamai.com"

# DNS variables
dns_zone = "jaescalo.com"

# Application Security variables
appsec_config_name = "tf-demo-appsec-config"
description        = "Spin up configuration via Terraform"
security_policy_name   = "tf-demo-policy"
security_policy_prefix = "TFDM"

# Activation for Application Security variables
appsec_network      = "STAGING"
notification_emails = ["juanperez@akamai.com"]
note                = "Activated by Terraform"
