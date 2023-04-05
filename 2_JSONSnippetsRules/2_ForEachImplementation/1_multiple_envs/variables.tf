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

variable "properties" {
  type = map(object({
    cpcode   = string
    origin   = string
    hostname = string
  }))
}