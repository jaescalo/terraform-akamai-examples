terraform {
  required_providers {
    akamai = {
      source = "akamai/akamai"
      version = "= 6.2.0"
    }
  }
  required_version = ">= 0.13"
}

provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "tf"
}