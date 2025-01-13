variable "config_name" {
  description = "Security configuration name"
  type        = string
}

variable "config_id" {
  description = "Security configuration ID"
  type        = number
}

variable "note" {
  description = "Notes for the activation"
  type        = string
}

variable "network" {
  description = "Activation network"
  type        = string
}

variable "notification_emails" {
  description = "List or emails for notifications"
  type        = list(string)
}
