resource "akamai_botman_challenge_injection_rules" "challenge_injection_rules" {
  config_id = akamai_appsec_configuration.config.config_id
  challenge_injection_rules = jsonencode(
    {
      "injectJavaScript" : false
    }
  )
}

