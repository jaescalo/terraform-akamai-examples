// IP/GEO/ASN Firewall
resource "akamai_appsec_ip_geo" "tfdemo" {
  config_id                  = akamai_appsec_configuration.config.config_id
  security_policy_id         = akamai_appsec_ip_geo_protection.tfdemo.security_policy_id
  mode                       = "block"
  ukraine_geo_control_action = "none"
}

