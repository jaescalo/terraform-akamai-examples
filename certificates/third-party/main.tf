# Used to read the contract ID based on the provided group name, it can also return the group id.
data "akamai_contract" "contract" {
  group_name = var.group_name
}

# Create the cert enrollment. 
resource "akamai_cps_third_party_enrollment" "enrollment" {
  contract_id                           = data.akamai_contract.contract.id
  common_name                           = var.common_name
  sans                                  = var.sans
  secure_network                        = var.secure_network
  sni_only                              = var.sni_only
  acknowledge_pre_verification_warnings = true
  auto_approve_warnings                 = var.auto_approve_warnings
  signature_algorithm                   = var.signature_algorithm
  change_management                     = var.change_management

  admin_contact {
    first_name       = var.admin_first_name
    last_name        = var.admin_last_name
    phone            = var.admin_phone
    email            = var.admin_email
    address_line_one = var.admin_address_line_one
    city             = var.admin_city
    country_code     = var.admin_country_code
    organization     = var.admin_organization
    postal_code      = var.admin_postal_code
    region           = var.admin_region
    title            = var.admin_title
  }

  tech_contact {
    first_name       = var.tech_first_name
    last_name        = var.tech_last_name
    phone            = var.tech_phone
    email            = var.tech_email
    address_line_one = var.tech_address_line_one
    city             = var.tech_city
    country_code     = var.tech_country_code
    organization     = var.tech_organization
    postal_code      = var.tech_postal_code
    region           = var.tech_region
    title            = var.tech_title
  }

  csr {
    country_code        = var.csr_country_code
    city                = var.csr_city
    organization        = var.csr_organization
    organizational_unit = var.csr_organizational_unit
    state               = var.csr_state
  }

  network_configuration {
    disallowed_tls_versions = var.disallowed_tls_versions
    clone_dns_names         = var.clone_dns_names
    geography               = var.geography
    ocsp_stapling           = var.ocsp_stapling
    preferred_ciphers       = var.preferred_ciphers
    must_have_ciphers       = var.must_have_ciphers
    quic_enabled            = var.quic_enabled
  }

  organization {
    name             = var.org_name
    phone            = var.org_phone
    address_line_one = var.org_address_line_one
    city             = var.org_city
    country_code     = var.org_country_code
    postal_code      = var.org_postal_code
    region           = var.org_region
  }
}

# Get the CSR created for the third party cert
data "akamai_cps_csr" "csr" {
  enrollment_id = akamai_cps_third_party_enrollment.enrollment.id
}

# Upload both RSA and ECDSA certs to Akamai
resource "akamai_cps_upload_certificate" "upload_cert" {
  enrollment_id                          = akamai_cps_third_party_enrollment.enrollment.id
  certificate_rsa_pem                    = acme_certificate.rsa_certificate.certificate_pem
  trust_chain_rsa_pem                    = acme_certificate.rsa_certificate.issuer_pem
  certificate_ecdsa_pem                  = acme_certificate.ecdsa_certificate.certificate_pem
  trust_chain_ecdsa_pem                  = acme_certificate.ecdsa_certificate.issuer_pem
  acknowledge_post_verification_warnings = true
  acknowledge_change_management          = true
  wait_for_deployment                    = true

  timeouts {
    default = "1h"
  }
}
