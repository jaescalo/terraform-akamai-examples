# -------------------------------------------------
# Common Variables 
# -------------------------------------------------
variable "contract_id" {
  description = "Akamai Contract ID"
  type        = string
}
variable "group_name" {
  description = "Akamai Group Name"
  type        = string
}
variable "config_name" {
  description = "Security configuration name"
  type        = string
}
variable "description" {
  default = "Security configuration description"
  type    = string
}
variable "hostnames" {
  description = "Hostnames to protect by the security config"
  type        = list(string)
}

# -------------------------------------------------
# Protections
# -------------------------------------------------
variable "enable_waf" {
  description = "Enable Web Application Firewall Protection"
  type        = bool
}
variable "enable_request_constraints" {
  description = "Enable API Requests Constraints Protection"
  type        = bool
}
variable "enable_ip_geo" {
  description = "Enable IP/Geo Firewall Protection"
  type        = bool
}
variable "enable_malware" {
  description = "Enable Malware Protection"
  type        = bool
}
variable "enable_rate" {
  description = "Enable Rate Protection"
  type        = bool
}
variable "enable_slow_post" {
  description = "Enable Slow POST Protection"
  type        = bool
}
# -------------------------------------------------
# Global advanced settings
# -------------------------------------------------
variable "pragma_header_name" {
  description = "Name for the header to match to expose pragma headers"
  type        = string
}
variable "pragma_header_value" {
  description = "Value for the header to match to expose pragma headers"
  type        = string
}

# -------------------------------------------------
# Specifics for the Security Policy
# -------------------------------------------------
# Security Policy Details
variable "policy_name" {
  description = "Name for the security policy"
  type        = string
}
variable "policy_prefix" {
  description = "Prefix for the security policy"
  type        = string
}

# IP/Geo Firewall
variable "ip_network_lists" {
  description = "List or IP Client/Network lists"
  type        = list(string)
}
variable "geo_network_lists" {
  description = "List of Geo Client/Network lists"
  type        = list(string)
}
variable "exception_ip_network_lists" {
  description = "List of block exceptions"
  type        = list(string)
}

# Dos Protection
variable "dos_origin_error_action" {
  description = "Action for the Origin Error"
  type        = string
}
variable "dos_post_page_requests_action" {
  description = "Action for the POST Page Requests"
  type        = string
}
variable "dos_page_view_requests_action" {
  description = "Action for the Page View Requests"
  type        = string
}
variable "slow_post_action" {
  description = "Action for the slow POST Protection"
  type        = string
}

# Custom Rule Actions by ID (commonly for XML rules)
variable "custom_rules_by_id" {
  description = "Map of custom rule IDs to their corresponding actions"
  type        = map(string)
}

# Custom Rule Actions
variable "custom_bad_user_agent_action" {
  description = "Action for custom rule: Bad User Agent"
  type        = string
}
variable "custom_bad_user_agent_2_action" {
  description = "Action for custom rule: Bad User Agent 2"
  type        = string
}

# Web Application Firewall (WAF) Actions
variable "waf_policy_action" {
  description = "Action for WAF attack group: Web Policy Violation"
  type        = string
}
variable "waf_wat_action" {
  description = "Action for WAF attack group: Web Attack Tool"
  type        = string
}
variable "waf_protocol_action" {
  description = "Action for WAF attack group: Web Protocol Attack"
  type        = string
}
variable "waf_sql_action" {
  description = "Action for WAF attack group: SQL Injection"
  type        = string
}
variable "waf_xss_action" {
  description = "Action for WAF attack group: Cross Site Scripting"
  type        = string
}
variable "waf_cmd_action" {
  description = "Action for WAF attack group: Command Injection"
  type        = string
}
variable "waf_lfi_action" {
  description = "Action for WAF attack group: Local File Inclusion"
  type        = string
}
variable "waf_rfi_action" {
  description = "Action for WAF attack group: Remote File Inclusion"
  type        = string
}
variable "waf_platform_action" {
  description = "Action for WAF attack group: Web Platform Attack"
  type        = string
}
variable "penalty_box_action" {
  description = "Action for WAF Penalty Box"
  type        = string
}



