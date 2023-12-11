variable "group_name" {
  type        = string
  description = "Akamai Group Name"
}

variable "product_id" {
  type        = string
  default     = "Fresca"
  description = "Akamai Property Product ID"
}

variable "cp_code_name" {
  type        = string
  description = "Name for the CP Code"
}

variable "edge_hostname" {
  type        = string
  description = "Akamai Edge Hostname"
}

variable "property_name" {
  type        = string
  description = "Akamai Property/Configuration Name"
}

variable "property_hostnames" {
  type        = list(string)
  description = "Hostnames"
}

variable "email" {
  type        = string
  description = "Notification email"
}
