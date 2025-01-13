resource "akamai_botman_javascript_injection" "tfdemo" {
  config_id          = var.config_id
  security_policy_id = var.security_policy_id
  javascript_injection = jsonencode(
    {
      "injectJavaScript" : "AROUND_PROTECTED_OPERATIONS",
      "rules" : []
    }
  )
}
