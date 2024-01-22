// IP/GEO Firewall
resource "akamai_appsec_ip_geo" "tf_demo_jaescalo_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_ip_geo_protection.tf_demo_jaescalo_policy.security_policy_id
  mode               = "block"
  ip_network_lists   = ["9146_TEST"]
}

