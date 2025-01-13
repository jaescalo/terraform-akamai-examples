output "config_id" {
  value = akamai_appsec_configuration.config.config_id
}

output "security_policy_id" {
  value = akamai_appsec_security_policy.tfdemo.security_policy_id
}
