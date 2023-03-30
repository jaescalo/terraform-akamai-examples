# variable contract_id reflects your Akamai Contract ID.
variable "contract_id" {}

# variable group_name reflects the name of your group you want to store your config. Groups are part of an Akamai contract.
variable "group_id" {}

# variable hostname reflects the hostname you wish to have Akamai deliver and protect.
variable "hostname" {}

# variable configuration_name reflects the name of your Akamai Application Security configuration. 
variable "configuration_name" {}

# variable configuration_description reflects a description for your Akamai Application Security configuration.
variable "configuration_description" {}

# variable policy_name reflects the name of your Security Policy that is part of you Akamai Application Security configuration.
variable "policy_name" {}

# variable policy_prefix reflects a four digit alphanummerical prefix for your Security Policy.
variable "policy_prefix" {}

# variable ipblock_list reflects an array of IP addresses that should be blocked from accessing your hostname.
variable "ipblock_list" {}

# variable ipblock_list_exceptions reflects an array of IP addresses that should be ALWAYS ALLOWED to access your hostname.
variable "ipblock_list_exceptions" {}

# variable geoblock_list reflects an array of countries in two digit formatting (US - NL etc.) that should be blocked from accessing your hostname.
variable "geoblock_list" {}

# variable ipblock_list reflects an array of IP addresses that should FULLY BYPASS ANY PROTECTION part of Akamai Application Security.
variable "securitybypass_list" {}

# the following variables reflect the ACTION for each of the Rate Policies, Slow POST Protection and Attack Groups. Can be set to ALERT, DENY or NONE.
variable "ratepolicy_page_view_requests_action" {}
variable "ratepolicy_origin_error_action" {}
variable "ratepolicy_post_requests_action" {}
variable "slow_post_protection_action" {}
variable "attack_group_web_attack_tool_action" {}
variable "attack_group_web_protocol_attack_action" {}
variable "attack_group_sql_injection_action" {}
variable "attack_group_cross_site_scripting_action" {}
variable "attack_group_local_file_inclusion_action" {}
variable "attack_group_remote_file_inclusion_action" {}
variable "attack_group_command_injection_action" {}
variable "attack_group_web_platform_attack_action" {}
variable "attack_group_web_policy_violation_action" {}
variable "attack_group_total_outbound_action" {}

# variable activation_notes reflects the activation notes for your Akamai Application Security configuration version. Required to deploy changes.
variable "activation_notes" {}

# variable network reflects Akamai STAGING or Akamai PRODUCTION.
variable "network" {}

# variable email reflects the email address to receive activation emails on.
variable "email" {}