output "enrollment_id" {
  value = akamai_cps_dv_enrollment.enrollment.id
}

output "dns_challenges" {
  value = akamai_cps_dv_enrollment.enrollment.dns_challenges
}

output "dns_challenges_map" {
  # dns_challenges attribute structure converted into a map for use in for_eachß
  value = { for entry in akamai_cps_dv_enrollment.enrollment.dns_challenges : entry.domain => entry }
}

output "all_hostnames" {
  value = concat([var.common_name], var.sans)
}
