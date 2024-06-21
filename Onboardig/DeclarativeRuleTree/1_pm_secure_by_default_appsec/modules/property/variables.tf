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

variable "origin_server" {
  type        = string
  description = "Origin Server"
}

variable "activate_in_staging" {
  type        = bool
  description = "Activate Staging"
}

variable "activate_in_production" {
  type        = bool
  description = "Activate Production"
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

variable "certificate_enrollment_id" {
  type        = number
  description = "Certificate Enrollment ID"
}

variable "cert_provisioning_type" {
  type        = string
  description = "Certificate Provisioning Type"
}

