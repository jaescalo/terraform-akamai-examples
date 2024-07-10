# -------------------------------------------------
# Common Variables 
# -------------------------------------------------

variable "group_name" {
  description = "Akamai Group Name"
  type        = string
}

variable "product_id" {
  description = "Akamai Property Product ID"
  type        = string
  default     = "Fresca"
}

# -------------------------------------------------
# Edge Hostname
# -------------------------------------------------

variable "edge_hostname" {
  description = "Akamai Edge Hostname"
  type        = string
}

variable "edge_hostname_ip_behavior" {
  description = "Akamai Edge Hostname IP behavior"
  type        = string
  default     = "IPV6_COMPLIANCE"
}

# -------------------------------------------------
# Property
# -------------------------------------------------

variable "property_name" {
  description = "Akamai Property/Configuration Name"
  type        = string
}

variable "property_hostnames" {
  type        = list(string)
  description = "Hostnames"
}

variable "cp_code_name" {
  description = "Name for the CP Code"
  type        = string
}

variable "origin_hostname" {
  type = string
  description = "Origin hostname"
}

variable "version_notes" {
  type        = string
  description = "Version Notes for the Property"
}

variable "email" {
  type        = string
  description = "Notification email"
}

variable "activate_property_on_staging" {
  type = bool
}

variable "activate_property_on_production" {
  type = bool
}