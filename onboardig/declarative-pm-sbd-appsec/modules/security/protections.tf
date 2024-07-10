// Enable/Disable Protections for policy tfdemo
resource "akamai_appsec_waf_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_security_policy.tfdemo.security_policy_id
  enabled            = true
}

resource "akamai_appsec_api_constraints_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_waf_protection.tfdemo.security_policy_id
  enabled            = true
}

resource "akamai_appsec_ip_geo_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_api_constraints_protection.tfdemo.security_policy_id
  enabled            = true
}

resource "akamai_appsec_malware_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_ip_geo_protection.tfdemo.security_policy_id
  enabled            = true
}

resource "akamai_appsec_rate_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_malware_protection.tfdemo.security_policy_id
  enabled            = true
}

resource "akamai_appsec_reputation_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_rate_protection.tfdemo.security_policy_id
  enabled            = true
}

resource "akamai_appsec_slowpost_protection" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_reputation_protection.tfdemo.security_policy_id
  enabled            = true
}

resource "akamai_botman_bot_management_settings" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_slowpost_protection.tfdemo.security_policy_id
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
