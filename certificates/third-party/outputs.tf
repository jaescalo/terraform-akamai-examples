# Output the enrollment ID to use it on other modules if needed
output "enrollment_id" {
  value = akamai_cps_third_party_enrollment.enrollment.id
}
