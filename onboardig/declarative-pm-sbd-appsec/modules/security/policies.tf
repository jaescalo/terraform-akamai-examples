resource "akamai_appsec_security_policy" "tfdemo" {
  config_id              = akamai_appsec_configuration.config.config_id
  default_settings       = true
  security_policy_name   = "tf-demo"
  security_policy_prefix = "TF01"
}

