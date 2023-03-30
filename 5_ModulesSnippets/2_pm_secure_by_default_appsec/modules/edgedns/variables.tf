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

variable "property_hostname" {
  type        = string
  description = "Hostname"
}