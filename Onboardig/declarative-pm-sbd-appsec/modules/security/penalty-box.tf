// Penalty Box
resource "akamai_appsec_penalty_box" "tfdemo" {
  config_id              = akamai_appsec_configuration.config.config_id
  security_policy_id     = akamai_appsec_security_policy.tfdemo.security_policy_id
  penalty_box_protection = true
  penalty_box_action     = "alert"
}
