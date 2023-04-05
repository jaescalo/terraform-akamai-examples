variable "network" {
  type        = string
  default     = "staging"
  description = "Deploy to Akamai STAGING or PRODUCTION network"
}

variable "contact" {
  type        = list(string)
  description = "Notification email"
}

variable "origin" {
  type        = string
  description = "Origin Hostname"
}

variable "origin_default_cn_list" {
  type    = list(any)
  default = []
}

variable "comments" {
  type        = string
  description = "Property Version Notes"
}

variable "property_and_edge_hostnames" {
  type = list(object({
    property_hostname = string
    edge_hostname     = string
  }))
  description = "Property and Edge Hostnames"
}