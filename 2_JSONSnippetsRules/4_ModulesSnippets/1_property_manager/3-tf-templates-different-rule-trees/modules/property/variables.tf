variable "group_name" {
  default = "My Group"
}

variable "product_id" {
  default = "prd_SPM"
}

variable "customer_env" {
  default = ""
}

variable "comments" {
  default = "Added by Terraform"
}

variable "origin" {
  default = ""
}

variable "cpcode" {
  default = ""
}

variable "property_and_edge_hostnames" {
  type = list(object({
    property_hostname = string
    edge_hostname     = string
  }))
  description = "Property and Edge Hostnames"
  default     = []
}

variable "contact" {
  default = [""]
}

variable "network" {
  default = "staging"
}