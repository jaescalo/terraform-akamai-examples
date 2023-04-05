terraform {
  required_providers {
    akamai = {
      source = "akamai/akamai"
    }
  }
}

resource "akamai_dns_record" "my_hostnames_to_akamaize" {
  zone       = var.dns_zone
  recordtype = "CNAME"
  ttl        = 300
  target     = [ var.edge_hostname ]
  name       = var.property_hostname
}