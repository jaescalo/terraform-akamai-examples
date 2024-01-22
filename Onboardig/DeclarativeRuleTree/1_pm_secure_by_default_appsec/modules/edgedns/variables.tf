variable "dns_zone" {
  type        = string
  description = "DNS Zone Name in Akamai EdgeDNS"
}

variable "contract_id" {
  type        = string
  description = "Akamai Contract ID"
}

variable "group_id" {
  type        = string
  description = "Akamai Group ID"
}

variable "property_id" {
  type        = string
  description = "Akamai Property ID"
}

variable "edge_hostname" {
  type        = string
  description = "Akamai Edge Hostname"
}

variable "dns_zam" {
  type        = string
  description = "Akamai Edge Hostname"
}

variable "dns_hostnames" {
  type        = list(string)
  description = "Hostname"
}

variable "email" {
  type        = string
  description = "Notification email"
}