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

variable "property" {
  type = object({
    name     = string
    cpcode   = string
    origin   = string
    hostname = string
  })
}