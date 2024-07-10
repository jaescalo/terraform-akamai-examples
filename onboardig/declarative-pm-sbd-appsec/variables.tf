# Environment variables (TF_VAR_*)

variable "akamai_client_secret" {}
variable "akamai_host" {}
variable "akamai_access_token" {}
variable "akamai_client_token" {}
variable "akamai_account_key" {}

# Common Variables

variable "group_name" {}
variable "email" {}

# Domain/Hostnames

variable "domain" {}
variable "hostnames" {}
variable "edge_hostname" {}

# Property 

variable "product_id" {}
variable "cp_code_name" {}
variable "origin_hostname" {}
variable "version_notes" {}
variable "activate_property_on_staging" {}
variable "activate_property_on_production" {}

# DNS

variable "ns_servers" {}
variable "soa_email" {}
variable "additional_records" {}
variable "challenge_validations" {}

# Security

variable "appsec_config_name" {}
variable "appsec_config_description" {}
variable "appsec_activation_note" {}
variable "activate_appsec_on_staging" {}
variable "activate_appsec_on_production" {}



