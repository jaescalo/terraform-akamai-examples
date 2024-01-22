// Enable/Disable Protections for policy tf_demo_jaescalo_policy
resource "akamai_appsec_waf_protection" "tf_demo_jaescalo_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_security_policy.tf_demo_jaescalo_policy.security_policy_id
  enabled            = true
}

resource "akamai_appsec_api_constraints_protection" "tf_demo_jaescalo_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_waf_protection.tf_demo_jaescalo_policy.security_policy_id
  enabled            = false
}

resource "akamai_appsec_ip_geo_protection" "tf_demo_jaescalo_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_api_constraints_protection.tf_demo_jaescalo_policy.security_policy_id
  enabled            = true
}

resource "akamai_appsec_rate_protection" "tf_demo_jaescalo_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_ip_geo_protection.tf_demo_jaescalo_policy.security_policy_id
  enabled            = false
}

resource "akamai_appsec_reputation_protection" "tf_demo_jaescalo_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_rate_protection.tf_demo_jaescalo_policy.security_policy_id
  enabled            = false
}

resource "akamai_appsec_slowpost_protection" "tf_demo_jaescalo_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_reputation_protection.tf_demo_jaescalo_policy.security_policy_id
  enabled            = true
}

