output "dns_challenges" {
  value = akamai_cps_dv_enrollment.enrollment.dns_challenges
}

output "count" {
  value = length(akamai_cps_dv_enrollment.enrollment.dns_challenges)
}

output "dns_challenges_map" {
  value = { for entry in akamai_cps_dv_enrollment.enrollment.dns_challenges : entry.domain => entry }
}

output "concat" {
  value = concat([var.common_name, ], var.sans)
}
