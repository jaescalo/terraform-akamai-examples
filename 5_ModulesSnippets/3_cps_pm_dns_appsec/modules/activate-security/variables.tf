# variable name reflects the application security configuration name
variable "name" {}

# variable config_id reflects the application security configuration ID number
variable "config_id" {}

# variable note reflects the activation notes for your Akamai Application Security configuration version. Required to deploy changes.
variable "note" {}

# variable network reflects Akamai STAGING or Akamai PRODUCTION.
variable "network" {}

# variable notification_emails reflects the email address to receive activation emails on.
variable "notification_emails" {}