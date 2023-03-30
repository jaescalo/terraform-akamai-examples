# Here's a slightly different variables.tf file where type, default, and description are used for the variable declaration

variable "group_name" {
  type        = string
  description = "Akamai Group Name"
}

variable "product_id" {
  type        = string
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

variable "rule_format" {
  type        = string
  description = "Property Manager Rule Format"
}

variable "property_hostname" {
  type        = string
  description = "Hostnames"
}

variable "email" {
  type        = string
  description = "Notification email"
}

variable "network" {
  type        = string
  default     = "staging"
  description = "Deploy to Akamai STAGING or PRODUCTION network"
}

variable "origin" {
  type        = string
  description = "Origin Hostname"
}
