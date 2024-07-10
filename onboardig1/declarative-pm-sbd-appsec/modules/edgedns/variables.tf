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
# Property
# -------------------------------------------------

variable "property_id" {
  description = "Property ID used to poll the DNS challenges"
  type        = string
}

# -------------------------------------------------
# DNS Zone & Records
# -------------------------------------------------

variable "dns_zone" {
  description = "DNS Zone Name in Akamai EdgeDNS"
  type        = string
}

variable "ns_servers" {
  description = "Akamai Name Servers list"
  type        = list(string)
}

variable "soa_email" {
  description = "Properly formatted email for the SOA DNS record"
  type        = string
}

variable "edge_hostname" {
  description = "Akamai Edge Hostname"
  type        = string
}

variable "dns_zam" {
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

variable "challenge_validations" {
  description = "Set to true or false whether you want to create the Secure By Default DNS validation records"
  type        = bool
  default     = false
}