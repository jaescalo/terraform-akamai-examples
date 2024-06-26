terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "= 5.5.0"
    }
  }
  required_version = ">= 0.13"
}

provider "akamai" {
  edgerc         = var.edgerc_location
  config_section = var.edgerc_section
}