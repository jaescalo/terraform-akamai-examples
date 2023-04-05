variable "edgerc_path" {
  type    = string
  default = "~/.edgerc"
}

variable "config_section" {
  type    = string
  default = "default"
}

variable "group_name" {
  type    = string
  default = "My Group"
}

variable "product_id" {
  type    = string
  default = "prd_Fresca"
}

variable "ip_behavior" {
  type    = string
  default = "IPV6_COMPLIANCE"
}

variable "hostname" {
  type    = string
  default = "tf-demo.host.com"
}

variable "edge_hostname" {
  type    = string
  default = "tf-demo.host.com.edgekey.com"
}

variable "property_name" {
  type    = string
  default = "tf-demo.host.com"
}

variable "rule_format" {
  type    = string
  default = "v2023-01-05"
}

variable "cert_provisioning_type" {
  type    = string
  default = "DEFAULT"
}

variable "email_contacts" {
  default = ["noreply@example.com"]
}

variable "env" {
  type    = string
  default = "staging"
}

# Rule tree variables
variable "cpcode" {
  type        = string
  description = "CP Code ID"
  default     = 1234567
}

variable "origin_server" {
  type        = string
  description = "Origin server hostname"
  default     = "origin.tf-demo.host.com"
} 