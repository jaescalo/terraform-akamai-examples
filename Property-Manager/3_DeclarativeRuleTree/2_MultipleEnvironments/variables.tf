# -------------------------------------------------
# Akamai Provider Variables
# -------------------------------------------------

variable "edgerc_location" {
  description = "Location for the .edgerc file with credentials"
  type        = string
  default     = "~/.edgerc"
}

variable "edgerc_section" {
  description = "Section in the .edgerc file to use"
  type        = string
  default     = "default"
}

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
  description = "Akamai Edge Hostname IP behavior (IPV4|IPV6_COMPLIANCE)"
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

variable "origin_parameters" {
  type = object({
    hostname           = string
    netstorage_cp_code = number
    type               = string
  })
  default = {
    hostname           = "www.example.com"
    netstorage_cp_code = null
    type               = "CUSTOMER"
  }
  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^CUSTOMER$|^NET_STORAGE$", var.origin_parameters.type))
    error_message = "Invalid origin type. Valid origin types are CUSTOMER or NET_STORAGE"
  }
}

variable "version_notes" {
  type        = string
  description = "Version Notes for the Property"
}

variable "emails" {
  type        = list(string)
  description = "Notification emails"
}
