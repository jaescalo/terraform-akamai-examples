terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "= 6.6.0"
    }
    linode = {
      source  = "linode/linode"
      version = "= 2.23.0"
    }
  }
  required_version = "= 1.9.0"
  backend "s3" {}
}