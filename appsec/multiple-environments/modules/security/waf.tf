resource "akamai_appsec_waf_mode" "tfdemo" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_waf_protection.tfdemo.security_policy_id
  mode               = "ASE_AUTO"
}

# Custom Rule Actions by ID (commonly for XML rules)
resource "akamai_appsec_custom_rule_action" "custom_rules" {
  for_each = var.custom_rules_by_id

  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_waf_protection.tfdemo.security_policy_id
  custom_rule_id     = each.key
  custom_rule_action = each.value
}

# Custom Rule Actions
resource "akamai_appsec_custom_rule_action" "tfdemo_bad_user_agent" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_waf_protection.tfdemo.security_policy_id
  custom_rule_id     = akamai_appsec_custom_rule.bad_user_agent_60286964.custom_rule_id
  custom_rule_action = var.custom_bad_user_agent_2_action
}

resource "akamai_appsec_custom_rule_action" "tfdemo_bad_user_agent_2" {
  config_id          = akamai_appsec_configuration.config.config_id
  security_policy_id = akamai_appsec_waf_protection.tfdemo.security_policy_id
  custom_rule_id     = akamai_appsec_custom_rule.bad_user_agent_2_60287283.custom_rule_id
  custom_rule_action = var.custom_bad_user_agent_action
}

# WAF Attack Group Actions
resource "akamai_appsec_attack_group" "tfdemo_POLICY" {
  config_id           = akamai_appsec_configuration.config.config_id
  security_policy_id  = akamai_appsec_waf_protection.tfdemo.security_policy_id
  attack_group        = "POLICY"
  attack_group_action = var.waf_policy_action
}

resource "akamai_appsec_attack_group" "tfdemo_WAT" {
  config_id           = akamai_appsec_configuration.config.config_id
  security_policy_id  = akamai_appsec_waf_protection.tfdemo.security_policy_id
  attack_group        = "WAT"
  attack_group_action = var.waf_wat_action
}

resource "akamai_appsec_attack_group" "tfdemo_PROTOCOL" {
  config_id           = akamai_appsec_configuration.config.config_id
  security_policy_id  = akamai_appsec_waf_protection.tfdemo.security_policy_id
  attack_group        = "PROTOCOL"
  attack_group_action = var.waf_protocol_action
}

resource "akamai_appsec_attack_group" "tfdemo_SQL" {
  config_id           = akamai_appsec_configuration.config.config_id
  security_policy_id  = akamai_appsec_waf_protection.tfdemo.security_policy_id
  attack_group        = "SQL"
  attack_group_action = var.waf_sql_action
}

resource "akamai_appsec_attack_group" "tfdemo_XSS" {
  config_id           = akamai_appsec_configuration.config.config_id
  security_policy_id  = akamai_appsec_waf_protection.tfdemo.security_policy_id
  attack_group        = "XSS"
  attack_group_action = var.waf_xss_action
}

resource "akamai_appsec_attack_group" "tfdemo_CMD" {
  config_id           = akamai_appsec_configuration.config.config_id
  security_policy_id  = akamai_appsec_waf_protection.tfdemo.security_policy_id
  attack_group        = "CMD"
  attack_group_action = var.waf_cmd_action
}

resource "akamai_appsec_attack_group" "tfdemo_LFI" {
  config_id           = akamai_appsec_configuration.config.config_id
  security_policy_id  = akamai_appsec_waf_protection.tfdemo.security_policy_id
  attack_group        = "LFI"
  attack_group_action = var.waf_lfi_action
}

resource "akamai_appsec_attack_group" "tfdemo_RFI" {
  config_id           = akamai_appsec_configuration.config.config_id
  security_policy_id  = akamai_appsec_waf_protection.tfdemo.security_policy_id
  attack_group        = "RFI"
  attack_group_action = var.waf_rfi_action
}

resource "akamai_appsec_attack_group" "tfdemo_PLATFORM" {
  config_id           = akamai_appsec_configuration.config.config_id
  security_policy_id  = akamai_appsec_waf_protection.tfdemo.security_policy_id
  attack_group        = "PLATFORM"
  attack_group_action = var.waf_platform_action
}


// Additionally WAF Rule Actions can be managed individually. For example
// CMD Injection Attack Detected (OS Commands 4)
# resource "akamai_appsec_rule" "tfdemo_aseweb_attackcmd_injection_950002" {
#   config_id          = akamai_appsec_configuration.config.config_id
#   security_policy_id = akamai_appsec_waf_protection.tfdemo.security_policy_id
#   rule_id            = "950002"
#   rule_action        = "alert"
# }
