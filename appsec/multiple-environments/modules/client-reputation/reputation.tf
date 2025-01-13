// Client Reputation Actions
resource "akamai_appsec_reputation_profile_action" "web_attackers_high_threat" {
  config_id             = var.config_id
  security_policy_id    = var.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.web_attackers_high_threat.reputation_profile_id
  action                = var.rep_web_attackers_high
}
resource "akamai_appsec_reputation_profile_action" "dos_attackers_high_threat" {
  config_id             = var.config_id
  security_policy_id    = var.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.dos_attackers_high_threat.reputation_profile_id
  action                = var.rep_dos_attackers_high
}
resource "akamai_appsec_reputation_profile_action" "scanning_tools_high_threat" {
  config_id             = var.config_id
  security_policy_id    = var.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.scanning_tools_high_threat.reputation_profile_id
  action                = var.rep_scanning_tools_high
}
resource "akamai_appsec_reputation_profile_action" "web_attackers_low_threat" {
  config_id             = var.config_id
  security_policy_id    = var.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.web_attackers_low_threat.reputation_profile_id
  action                = var.rep_web_attackers_low
}
resource "akamai_appsec_reputation_profile_action" "dos_attackers_low_threat" {
  config_id             = var.config_id
  security_policy_id    = var.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.dos_attackers_low_threat.reputation_profile_id
  action                = var.rep_dos_attackers_low
}
resource "akamai_appsec_reputation_profile_action" "scanning_tools_low_threat" {
  config_id             = var.config_id
  security_policy_id    = var.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.scanning_tools_low_threat.reputation_profile_id
  action                = var.rep_scanning_tools_low
}
resource "akamai_appsec_reputation_profile_action" "web_scrapers_low_threat" {
  config_id             = var.config_id
  security_policy_id    = var.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.web_scrapers_low_threat.reputation_profile_id
  action                = var.rep_web_scrapers_low
}
resource "akamai_appsec_reputation_profile_action" "web_scrapers_high_threat" {
  config_id             = var.config_id
  security_policy_id    = var.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.web_scrapers_high_threat.reputation_profile_id
  action                = var.rep_web_scrapers_high
}
