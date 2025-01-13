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
