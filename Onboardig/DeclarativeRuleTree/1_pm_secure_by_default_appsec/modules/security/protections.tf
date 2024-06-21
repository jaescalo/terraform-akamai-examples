// Enable/Disable Protections for policy
resource "akamai_appsec_waf_protection" "my_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_security_policy.my_policy.security_policy_id
  enabled            = true
}

resource "akamai_appsec_api_constraints_protection" "my_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_waf_protection.my_policy.security_policy_id
  enabled            = true
}

resource "akamai_appsec_ip_geo_protection" "my_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_api_constraints_protection.my_policy.security_policy_id
  enabled            = true
}

resource "akamai_appsec_malware_protection" "my_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_ip_geo_protection.my_policy.security_policy_id
  enabled            = false
}

resource "akamai_appsec_rate_protection" "my_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_malware_protection.my_policy.security_policy_id
  enabled            = true
}

resource "akamai_appsec_reputation_protection" "my_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_rate_protection.my_policy.security_policy_id
  enabled            = true
}

resource "akamai_appsec_slowpost_protection" "my_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_reputation_protection.my_policy.security_policy_id
  enabled            = true
}

resource "akamai_botman_bot_management_settings" "my_policy" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_slowpost_protection.my_policy.security_policy_id
  bot_management_settings = jsonencode(
    {
      "addAkamaiBotHeader" : false,
      "enableActiveDetections" : true,
      "enableBotManagement" : true,
      "enableBrowserValidation" : false,
      "removeBotManagementCookies" : false,
      "thirdPartyProxyServiceInUse" : false
    }
  )
}
