// Slow Post Protection
resource "akamai_appsec_slow_post" "tfdemo" {
  config_id                  = akamai_appsec_configuration.config.config_id
  security_policy_id         = akamai_appsec_slowpost_protection.tfdemo.security_policy_id
  slow_rate_action           = "alert"
  slow_rate_threshold_rate   = 10
  slow_rate_threshold_period = 60
}

