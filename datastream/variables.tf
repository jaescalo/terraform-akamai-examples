# -------------------------------------------------
# Environment variables (TF_VAR_*)
# -------------------------------------------------
variable "akamai_client_secret" {
  description = "Akamai client_secret API credential"
  type        = string
}
variable "akamai_host" {
  description = "Akamai host API credential"
  type        = string
}
variable "akamai_access_token" {
  description = "Akamai access_token API credential"
  type        = string
}
variable "akamai_client_token" {
  description = "Akamai client_token API credential"
  type        = string
}
variable "akamai_account_key" {
  description = "Akamai Account Key"
  type        = string
}
variable "sumologic_connector_code" {
  description = "Sumologic Connector Code"
  type        = string
}

# -------------------------------------------------
# Common Variables 
# -------------------------------------------------

variable "group_name" {
  description = "Akamai Group Name"
  type        = string
}

variable "stream_name" {
  description = "DataStream Name"
  type        = string
}

variable "properties" {
  description = "List of Associated Properties to the DataStream"
  type        = list(string)
}

variable "notification_emails" {
  description = "List of Notification Emails"
  type        = list(string)
}
