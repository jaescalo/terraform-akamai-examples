# Output the enrollment ID to use it on other modules
output "enrollment_id" {
  value = akamai_cps_third_party_enrollment.enrollment.id
}

# Output the CSR for reference
output "csr" {
  value = data.akamai_cps_csr.csr.csr_rsa
}