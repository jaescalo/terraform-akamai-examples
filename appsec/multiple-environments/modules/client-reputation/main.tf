resource "akamai_appsec_reputation_protection" "tfdemo" {
  config_id          = var.config_id
  security_policy_id = var.security_policy_id
  enabled            = true
}
