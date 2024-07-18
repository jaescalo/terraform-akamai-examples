# Environment variables (TF_VAR_*)

variable "akamai_client_secret" {}
variable "akamai_host" {}
variable "akamai_access_token" {}
variable "akamai_client_token" {}
variable "akamai_account_key" {}

variable "environment" {
  description = "Environment to deploy/activate"
  type    = string
}

variable "policy_name" {
  description = "Cloudlet Policy Name"
  type    = string
}

variable "description" {
  type    = string
  default = "ER Cloudlet deployed by TF"
}

variable "group_name" {
  description = "Akamai Group Name"
  type    = string
}

variable "cloudlet_code" {
  description = "Cloudlet Type Code"
  type    = string
  default = "ER"
}

variable "network" {
  description = "Akamai Network: staging or production"
  type    = string
  default = "staging"
}