provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

module "akamai_property" {
  source             = "./modules/property"
  group_name         = "My Group"
  product_id         = "Fresca"
  cp_code_name       = "tf-demo.host.com"
  edge_hostname      = "tf-demo.host.com.edgesuite.net"
  property_name      = "tf-demo-property"
  property_hostname  = "tf-demo.host.com"
  origin             = "origin.tf-demo.host.com"
  network            = "staging"
  email              = "noreply@example.com"
}

module "akamai_edgedns_records" {
  source      = "./modules/edgedns"
  dns_zone    = "host.com"
  edge_hostname      = "tf-demo.host.com.edgesuite.net"
  property_hostname = "tf-demo.host.com"
  contract_id = module.akamai_property.contract_id
  group_id    = module.akamai_property.group_id
  property_id = module.akamai_property.property_id
  depends_on = [ module.akamai_property ]
}

module "akamai_application_security" {
  source = "./modules/security"

  contract_id = module.akamai_property.contract_id
  group_id    = module.akamai_property.group_id

  configuration_name        = "tf-demo-appsec-configuration"
  configuration_description = "Spin up configuration via Terraform"

  hostname = "tf-demo.host.com"

  policy_name   = "TFDemoPolicy"
  policy_prefix = "TFDM"

  ipblock_list            = ["192.0.0.1"] # the list of IP/CIDR addresses you want to block
  ipblock_list_exceptions = ["192.0.0.2"] # the list of IP/CIDR addresses you want to block
  geoblock_list           = ["RU"]        # the list of GEO country codes you want to block
  securitybypass_list     = ["192.0.0.3"] # the list of IP/CIDR addresses you want to be able to bypass the security policy.

  ratepolicy_page_view_requests_action = "alert"
  ratepolicy_origin_error_action       = "alert"
  ratepolicy_post_requests_action      = "alert"
  slow_post_protection_action          = "alert"

  attack_group_web_attack_tool_action       = "deny"
  attack_group_web_protocol_attack_action   = "alert"
  attack_group_sql_injection_action         = "alert"
  attack_group_cross_site_scripting_action  = "alert"
  attack_group_local_file_inclusion_action  = "alert"
  attack_group_remote_file_inclusion_action = "alert"
  attack_group_command_injection_action     = "alert"
  attack_group_web_platform_attack_action   = "alert"
  attack_group_web_policy_violation_action  = "alert"
  attack_group_total_outbound_action        = "none"

  network          = "STAGING"
  email            = "noreply@example.com"
  activation_notes = "AppSec configuration deployed with the Akamai Terraform Provider."
  depends_on       = [ module.akamai_property ]
}