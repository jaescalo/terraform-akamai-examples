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

# -------------------------------------------------
# Application Security Config
# -------------------------------------------------

variable "name" {
  description = "Application Security Configuration Name"
  type        = string
}

variable "description" {
  description = "Description for the AppSec Configuration"
  type        = string
}

variable "hostnames" {
  description = "List of hostnames to protect"
  type        = list(string)
}
