resource "akamai_appsec_security_policy" "my_policy" {
  config_id              = akamai_appsec_configuration.config.config_id
  default_settings       = true
  security_policy_name   = "My Policy"
  security_policy_prefix = "G1TR"
}

