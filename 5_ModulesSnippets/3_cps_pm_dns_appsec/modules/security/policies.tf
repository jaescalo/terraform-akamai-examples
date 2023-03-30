resource "akamai_appsec_security_policy" "tf_demo_jaescalo_policy" {
  config_id              = akamai_appsec_configuration.config.config_id
  default_settings       = true
  security_policy_name   = var.security_policy_name
  security_policy_prefix = var.security_policy_prefix
}

