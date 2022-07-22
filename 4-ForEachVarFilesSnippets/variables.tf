variable "network" {
  type        = string
  default     = "staging"
  description = "Deploy to Akamai STAGING or PRODUCTION network"
}

variable "contact" {
  type        = list(string)
  default     = ["email@akamai.com"]
  description = "Notification email"
}

variable "customer_env" {
  type    = set(string)
  default = ["dev", "prod"]
}