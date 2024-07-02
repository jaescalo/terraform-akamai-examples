// Client Reputation Actions
resource "akamai_appsec_reputation_profile_action" "tfdemo_7191862" {
  config_id             = akamai_appsec_configuration.config.config_id
  security_policy_id    = akamai_appsec_reputation_protection.tfdemo.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.web_attackers_high_threat.reputation_profile_id
  action                = "alert"
}
resource "akamai_appsec_reputation_profile_action" "tfdemo_7191864" {
  config_id             = akamai_appsec_configuration.config.config_id
  security_policy_id    = akamai_appsec_reputation_protection.tfdemo.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.dos_attackers_high_threat.reputation_profile_id
  action                = "alert"
}
resource "akamai_appsec_reputation_profile_action" "tfdemo_7191866" {
  config_id             = akamai_appsec_configuration.config.config_id
  security_policy_id    = akamai_appsec_reputation_protection.tfdemo.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.scanning_tools_high_threat.reputation_profile_id
  action                = "alert"
}
resource "akamai_appsec_reputation_profile_action" "tfdemo_7191868" {
  config_id             = akamai_appsec_configuration.config.config_id
  security_policy_id    = akamai_appsec_reputation_protection.tfdemo.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.web_attackers_low_threat.reputation_profile_id
  action                = "alert"
}
resource "akamai_appsec_reputation_profile_action" "tfdemo_7191870" {
  config_id             = akamai_appsec_configuration.config.config_id
  security_policy_id    = akamai_appsec_reputation_protection.tfdemo.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.dos_attackers_low_threat.reputation_profile_id
  action                = "alert"
}
resource "akamai_appsec_reputation_profile_action" "tfdemo_7191872" {
  config_id             = akamai_appsec_configuration.config.config_id
  security_policy_id    = akamai_appsec_reputation_protection.tfdemo.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.scanning_tools_low_threat.reputation_profile_id
  action                = "alert"
}
resource "akamai_appsec_reputation_profile_action" "tfdemo_7191874" {
  config_id             = akamai_appsec_configuration.config.config_id
  security_policy_id    = akamai_appsec_reputation_protection.tfdemo.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.web_scrapers_low_threat.reputation_profile_id
  action                = "alert"
}
resource "akamai_appsec_reputation_profile_action" "tfdemo_7191876" {
  config_id             = akamai_appsec_configuration.config.config_id
  security_policy_id    = akamai_appsec_reputation_protection.tfdemo.security_policy_id
  reputation_profile_id = akamai_appsec_reputation_profile.web_scrapers_high_threat.reputation_profile_id
  action                = "alert"
}
