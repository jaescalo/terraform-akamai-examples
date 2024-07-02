terraform {
  required_providers {
    akamai = {
      source = "akamai/akamai"
      version = "= 6.2.0"
    }
  }
}

# Used to read the contract ID based on the provided group name, it can also return the group id.
data "akamai_contract" "contract" {
  group_name = var.group_name
}

# Create the cert enrollment. 
resource "akamai_cps_third_party_enrollment" "enrollment" {
  contract_id           = data.akamai_contract.contract.id
  common_name           = var.common_name
  secure_network        = var.secure_network
  sni_only              = var.sni_only
  auto_approve_warnings = var.auto_approve_warnings
  signature_algorithm   = var.signature_algorithm
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

# Save the CSR to a local file (i.e. domain.csr)
resource "local_file" "csr" {
  count  = var.renew == true ? 1 : 0

  content  = data.akamai_cps_csr.csr.csr_rsa
  filename = "${path.module}/CA/domain.csr"

  # As with any Akamai third party certificate once the CSR is downloaded it must be provided to the Certificate Authority to sign/create the certificate. This certificate is then uploaded to Akamai CPS
  # For illustration purposes ONLY this step is simulated by locally signing the certificate with a self signed root cert.
  # This step signs the certiricate and saves it as domain.crt
  # The ./CA folder is not included in this repository
  provisioner "local-exec" {
    working_dir = "${path.module}/CA/"
    command     = "openssl x509 -req -CA rootCA.pem -CAkey rootCA.key -in domain.csr -out domain.pem -days 365 -CAcreateserial -extfile domain.ext"
  }
}

# Upload the signed certificate and the trust chain. The activation to production is triggered as well.
resource "akamai_cps_upload_certificate" "upload_cert" {
  enrollment_id                          = akamai_cps_third_party_enrollment.enrollment.id
  certificate_rsa_pem                    = file("${path.module}/CA/domain.pem")
  trust_chain_rsa_pem                    = file("${path.module}/CA/rootCA.pem")
  acknowledge_post_verification_warnings = true
  acknowledge_change_management          = true
  wait_for_deployment                    = true
  depends_on = [ 
    local_file.csr 
  ]
}