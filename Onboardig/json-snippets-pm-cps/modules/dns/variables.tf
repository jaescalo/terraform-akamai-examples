# -------------------------------------------------
# Common Variables 
# -------------------------------------------------

variable "group_id" {
  description = "Akamai Group ID"
  type        = string
}

variable "contract_id" {
  description = "Akamai Contract ID"
  type        = string
}

# -------------------------------------------------
# DNS Zone & Records
# -------------------------------------------------

variable "dns_zone" {
  description = "DNS Zone Name in Akamai EdgeDNS"
  type        = string
}

variable "edge_hostname" {
  description = "Akamai Edge Hostname"
  type        = string
}

variable "dns_hostnames" {
  description = "Hostname"
  type        = list(string)
}

variable "additional_records" {
  description = "List of objects for additional records to configure"
  type = map(object({
    recordType = string
    ttl        = number
    target     = string
    name       = string
  }))
}