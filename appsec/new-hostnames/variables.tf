# Environment variables (TF_VAR_*)

variable "akamai_client_secret" {}
variable "akamai_host" {}
variable "akamai_access_token" {}
variable "akamai_client_token" {}
variable "akamai_account_key" {}

# -------------------------------------------------
# Common Variables 
# -------------------------------------------------

variable "group_name" {
  description = "Akamai Group Name"
  type        = string
}

variable "email" {
  type        = string
  description = "Notification email"
}

# -------------------------------------------------
# Application Security Config
# -------------------------------------------------

variable "appsec_config_name" {
  description = "Application Security Configuration Name"
  type        = string
}

variable "appsec_config_description" {
  description = "Description for the AppSec Configuration"
  type        = string
}

variable "appsec_activation_note" {
  description = "Activation notes for the AppSec Configuration"
  type        = string
}

variable "activate_appsec_on_staging" {
    description = "Activate the AppSec Configuration to staging"
    type = bool
    default = false
}

variable "activate_appsec_on_production" {
    description = "Activate the AppSec Configuration to production"
    type = bool
    default = false
}

variable "new_hostnames" {
  description = "List of new hostnames to protect"
  type        = list(string)
}
