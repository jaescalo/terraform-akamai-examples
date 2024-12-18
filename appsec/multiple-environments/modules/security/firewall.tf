// IP/GEO/ASN Firewall
resource "akamai_appsec_ip_geo" "tfdemo" {
  config_id                  = akamai_appsec_configuration.config.config_id
  security_policy_id         = akamai_appsec_ip_geo_protection.tfdemo.security_policy_id
  mode                       = "block"
  geo_network_lists          = var.geo_network_lists
  ip_network_lists           = var.ip_network_lists
  exception_ip_network_lists = var.exception_ip_network_lists
  ukraine_geo_control_action = "none"
}

