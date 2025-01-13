// Enable/Disable Protections for policy tfdemo
resource "akamai_appsec_waf_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_security_policy.tfdemo.security_policy_id
  enabled            = var.enable_waf
}

resource "akamai_appsec_api_constraints_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_security_policy.tfdemo.security_policy_id
  enabled            = var.enable_request_constraints
}

resource "akamai_appsec_ip_geo_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_security_policy.tfdemo.security_policy_id
  enabled            = var.enable_ip_geo
}

resource "akamai_appsec_malware_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_security_policy.tfdemo.security_policy_id
  enabled            = var.enable_malware
}

resource "akamai_appsec_rate_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_security_policy.tfdemo.security_policy_id
  enabled            = var.enable_rate
}

resource "akamai_appsec_slowpost_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_security_policy.tfdemo.security_policy_id
  enabled            = var.enable_slow_post
}
