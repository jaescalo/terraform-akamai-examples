# resource for the Akamai Application Security configuration, tied to an Akamai Contract and Group. Can have multiple hostnames.
resource "akamai_appsec_configuration" "akamai_appsec" {
  contract_id = replace(var.contract_id, "ctr_", "")
  group_id    = replace(var.group_id, "grp_", "")
  name        = var.configuration_name
  description = var.configuration_description
  host_names  = [var.hostname]
}

# resource for the Akamai Application Security Policy, tied to an Application Security configuration.
resource "akamai_appsec_security_policy" "security_policy" {
  config_id              = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_name   = var.policy_name
  security_policy_prefix = var.policy_prefix
  default_settings       = true
}

# resource to set the Application Security mode. Currently set to Adaptive Security Engine in Automatic mode which required the least management.
resource "akamai_appsec_waf_mode" "default_policy" {
  config_id          = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  mode               = "ASE_AUTO"
}

# resource to set how Akamai handles the Akamai Pragma Header. They will be removed by default UNLESS query string ENABLEDEBUG is added.
resource "akamai_appsec_advanced_settings_pragma_header" "pragma_header" {
  config_id          = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  pragma_header      = file("${path.module}/appsec-snippets/pragma_header.json")
}

# resource to set Match Target for the Security Policy, settings are set in /appsec-snippets/match_targets.json.
resource "akamai_appsec_match_target" "match_target" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  match_target = templatefile("${path.module}/appsec-snippets/match_targets.json", {
    config_id           = akamai_appsec_configuration.akamai_appsec.config_id,
    hostname            = var.hostname,
    policy_id           = akamai_appsec_security_policy.security_policy.security_policy_id
    securitybypass_list = akamai_networklist_network_list.SECURITYBYPASSLIST.id
    }
  )
}

# resource to set IP addresses in the IPBLOCKLIST, REPLACE mode will always 100% fully update all entries.
resource "akamai_networklist_network_list" "IPBLOCKLIST" {
  name        = "IPBLOCKLIST"
  type        = "IP"
  description = "IPBLOCKLIST"
  list        = var.ipblock_list
  mode        = "REPLACE"
}

# resource to activate the Akamai Network List.
resource "akamai_networklist_activations" "activation_IPBLOCKLIST" {
  network_list_id     = akamai_networklist_network_list.IPBLOCKLIST.id
  network             = var.network
  notes               = var.activation_notes
  notification_emails = [var.email]
}

# resource to set IP addresses in the IPBLOCKLISTEXCEPTIONS, REPLACE mode will always 100% fully update all entries.
resource "akamai_networklist_network_list" "IPBLOCKLISTEXCEPTIONS" {
  name        = "IPBLOCKLISTEXCEPTIONS"
  type        = "IP"
  description = "IPBLOCKLISTEXCEPTIONS"
  list        = var.ipblock_list_exceptions
  mode        = "REPLACE"
}

# resource to activate the Akamai Network List.
resource "akamai_networklist_activations" "activation_IPBLOCKLISTEXCEPTIONS" {
  network_list_id     = akamai_networklist_network_list.IPBLOCKLISTEXCEPTIONS.id
  network             = var.network
  notes               = var.activation_notes
  notification_emails = [var.email]
}

# resource to set GEOs in country codes in the GEOBLOCKLIST, REPLACE mode will always 100% fully update all entries.
resource "akamai_networklist_network_list" "GEOBLOCKLIST" {
  name        = "GEOBLOCKLIST"
  type        = "GEO"
  description = "GEOBLOCKLIST"
  list        = var.geoblock_list
  mode        = "REPLACE"
}

# resource to activate the Akamai Network List.
resource "akamai_networklist_activations" "activation_GEOBLOCKLIST" {
  network_list_id     = akamai_networklist_network_list.GEOBLOCKLIST.id
  network             = var.network
  notes               = var.activation_notes
  notification_emails = [var.email]
}

# resource to set IP addresses in the SECUITYBYPASSLIST, REPLACE mode will always 100% fully update all entries.
resource "akamai_networklist_network_list" "SECURITYBYPASSLIST" {
  name        = "SECURITYBYPASSLIST"
  type        = "IP"
  description = "SECURITYBYPASSLIST"
  list        = var.securitybypass_list
  mode        = "REPLACE"
}

# resource to activate the Akamai Network List.
resource "akamai_networklist_activations" "activation_SECURITYBYPASSLIST" {
  network_list_id     = akamai_networklist_network_list.SECURITYBYPASSLIST.id
  network             = var.network
  notes               = var.activation_notes
  notification_emails = [var.email]
}

# resource to set all the Network Lists properly in DENY/BLOCKING mode.
resource "akamai_appsec_ip_geo" "ip_geo_block" {
  config_id                  = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id         = akamai_appsec_security_policy.security_policy.security_policy_id
  mode                       = "block"
  ip_network_lists           = [akamai_networklist_network_list.IPBLOCKLIST.id]
  geo_network_lists          = [akamai_networklist_network_list.GEOBLOCKLIST.id]
  exception_ip_network_lists = [akamai_networklist_network_list.IPBLOCKLISTEXCEPTIONS.id]
}

# resource to create Page View Requests Rate Policy which trigger based on amount of page views.
resource "akamai_appsec_rate_policy" "rate_policy_page_view_requests" {
  config_id   = akamai_appsec_configuration.akamai_appsec.config_id
  rate_policy = file("${path.module}/appsec-snippets/rate-policies/rate_policy_page_view_requests.json")
}

resource "akamai_appsec_rate_policy_action" "appsec_rate_policy_page_view_requests_action" {
  config_id          = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  rate_policy_id     = akamai_appsec_rate_policy.rate_policy_page_view_requests.rate_policy_id
  ipv4_action        = var.ratepolicy_page_view_requests_action
  ipv6_action        = var.ratepolicy_page_view_requests_action
}

# resource to create Origin error Rate Policy which trigger based on amount of origin errors.
resource "akamai_appsec_rate_policy" "rate_policy_origin_error" {
  config_id   = akamai_appsec_configuration.akamai_appsec.config_id
  rate_policy = file("${path.module}/appsec-snippets/rate-policies/rate_policy_origin_error.json")
}

resource "akamai_appsec_rate_policy_action" "appsec_rate_policy_origin_error_action" {
  config_id          = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  rate_policy_id     = akamai_appsec_rate_policy.rate_policy_origin_error.rate_policy_id
  ipv4_action        = var.ratepolicy_origin_error_action
  ipv6_action        = var.ratepolicy_origin_error_action
}

# resource to create POST Requests Rate Policy which trigger based on amount of POST requests.
resource "akamai_appsec_rate_policy" "rate_policy_post_requests" {
  config_id   = akamai_appsec_configuration.akamai_appsec.config_id
  rate_policy = file("${path.module}/appsec-snippets/rate-policies/rate_policy_post_requests.json")
}

resource "akamai_appsec_rate_policy_action" "appsec_rate_policy_post_requests_action" {
  config_id          = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  rate_policy_id     = akamai_appsec_rate_policy.rate_policy_post_requests.rate_policy_id
  ipv4_action        = var.ratepolicy_post_requests_action
  ipv6_action        = var.ratepolicy_post_requests_action
}

# resource to set the SLOW POST Protection to best practice standards.
resource "akamai_appsec_slow_post" "slow_post" {
  config_id                  = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id         = akamai_appsec_security_policy.security_policy.security_policy_id
  slow_rate_action           = var.slow_post_protection_action
  slow_rate_threshold_rate   = 10
  slow_rate_threshold_period = 60
}

# 10 resources that reflect the Adaptive Security Engine Attack Groups. Exception can be added in JSON for each of the groups. Actions can be set to ALERT/DENY/NONE in variables.

resource "akamai_appsec_attack_group" "attack_group_web_attack_tool" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "WAT"
  attack_group_action = var.attack_group_web_attack_tool_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_web_attack_tool_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_web_protocol_attack" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "PROTOCOL"
  attack_group_action = var.attack_group_web_protocol_attack_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_web_protocol_attack_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_sql_injection" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "SQL"
  attack_group_action = var.attack_group_sql_injection_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_sql_injection_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_cross_site_scripting" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "XSS"
  attack_group_action = var.attack_group_cross_site_scripting_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_cross_site_scripting_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_local_file_inclusion" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "LFI"
  attack_group_action = var.attack_group_local_file_inclusion_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_local_file_inclusion_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_remote_file_inclusion" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "RFI"
  attack_group_action = var.attack_group_remote_file_inclusion_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_remote_file_inclusion_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_command_injection" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "CMD"
  attack_group_action = var.attack_group_command_injection_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_command_injection_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_web_platform_attack" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "PLATFORM"
  attack_group_action = var.attack_group_web_platform_attack_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_web_platform_attack_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_web_policy_violation" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "POLICY"
  attack_group_action = var.attack_group_web_policy_violation_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_web_policy_violation_exception.json")
}

# Total Outbound is typically set to Not Used/None because it can negatively impact performance. Enable into ALERT/DENY with care.
resource "akamai_appsec_attack_group" "attack_group_total_outbound" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id  = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group        = "OUTBOUND"
  attack_group_action = var.attack_group_total_outbound_action
  #condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_total_outbound_exception.json")
}

# resource to activate the Akamai Application Security configuration
resource "akamai_appsec_activations" "activation" {
  config_id           = akamai_appsec_configuration.akamai_appsec.config_id
  network             = upper(var.network)
  notes               = var.activation_notes
  notification_emails = [var.email]

  depends_on = [
    akamai_appsec_configuration.akamai_appsec,
    akamai_appsec_security_policy.security_policy,
    akamai_appsec_advanced_settings_pragma_header.pragma_header,
    akamai_appsec_match_target.match_target,
    akamai_appsec_ip_geo.ip_geo_block,
    akamai_appsec_rate_policy.rate_policy_page_view_requests,
    akamai_appsec_rate_policy.rate_policy_origin_error,
    akamai_appsec_rate_policy.rate_policy_post_requests,
    akamai_appsec_slow_post.slow_post
  ]
}