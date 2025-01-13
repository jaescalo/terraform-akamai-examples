resource "akamai_botman_bot_management_settings" "tfdemo" {
  config_id          = var.config_id
  security_policy_id = var.security_policy_id
  bot_management_settings = jsonencode(
    {
      "addAkamaiBotHeader" : var.add_akamai_bot_header,
      "enableActiveDetections" : var.enable_active_detections,
      "enableBotManagement" : true
      "enableBrowserValidation" : var.enable_browser_validation,
      "removeBotManagementCookies" : var.remove_botman_cookies,
      "thirdPartyProxyServiceInUse" : var.third_party_proxy
    }
  )
}

resource "akamai_botman_client_side_security" "client_side_security" {
  config_id = var.config_id
  client_side_security = jsonencode(
    {
      "useAllSecureTraffic" : false,
      "useSameSiteCookies" : false,
      "useStrictCspCompatibility" : false
    }
  )
}

resource "akamai_botman_transactional_endpoint_protection" "transactional_endpoint_protection" {
  config_id = var.config_id
  transactional_endpoint_protection = jsonencode(
    {
      "inlineTelemetry" : {
        "aggressiveThreshold" : 90,
        "detectionSetType" : "BOT_SCORE",
        "safeguardAction" : "USE_STRICT_ACTION",
        "strictThreshold" : 50
      },
      "sdkTelemetry" : {
        "androidAggressiveThreshold" : 90,
        "androidStrictThreshold" : 50,
        "detectionSetType" : "BOT_SCORE_SDK",
        "iosAggressiveThreshold" : 90,
        "iosStrictThreshold" : 50,
        "safeguardAction" : "USE_STRICT_ACTION"
      },
      "standardTelemetry" : {
        "aggressiveThreshold" : 90,
        "detectionSetType" : "BOT_SCORE",
        "safeguardAction" : "USE_STRICT_ACTION",
        "strictThreshold" : 50
      }
    }
  )
}
