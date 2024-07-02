# -------------------------------------------------
# Application Security Config Activation
# -------------------------------------------------

variable "name" {
  description = "Application Security Configuration Name"
  type        = string
}

variable "config_id" {
  description = "Application Security Configuration ID"
  type        = number
}

variable "note" {
  description = "Application Security Config Activation Note"
  type        = string
}

variable "notification_emails" {
  description = "Notification emails for the activation"
  type        = list(string)
}

variable "activate_appsec_on_staging" {
  description = "Activate APPSEC version to staging"
  type        = bool
}

variable "activate_appsec_on_production" {
  description = "Activate APPSEC version to production"
  type        = bool
}