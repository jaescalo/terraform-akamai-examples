# Global settings
variable "config_id" {
  default = "Akamai security configuration ID"
  type    = string
}
variable "security_policy_id" {
  description = "Security policy ID"
  type        = string
}

# Client Reputation Actions
variable "rep_web_attackers_high" {
  description = "Action for Reputation Profile:  Web Attackers (High Threat)"
  type        = string
}
variable "rep_dos_attackers_high" {
  description = "Action for Reputation Profile: DoS Attackers (High Threat)"
  type        = string
}
variable "rep_scanning_tools_high" {
  description = "Action for Reputation Profile: Scanning Tools (High Threat)"
  type        = string
}
variable "rep_web_attackers_low" {
  description = "Action for Reputation Profile: Web Attackers (Low Threat)"
  type        = string
}
variable "rep_dos_attackers_low" {
  description = "Action for Reputation Profile: DoS Attackers (Low Threat)"
  type        = string
}
variable "rep_scanning_tools_low" {
  description = "Action for Reputation Profile: Scanning Tools (Low Threat)"
  type        = string
}
variable "rep_web_scrapers_low" {
  description = "Action for Reputation Profile: Web Scrapers (Low Threat)"
  type        = string
}
variable "rep_web_scrapers_high" {
  description = "Action for Reputation Profile: Web Scrapers (High Threat)"
  type        = string
}
