# Get Akamai property hostnames status for challenges for Secure by Default
data "akamai_property_hostnames" "tf_demo_hostnames" {
  contract_id = var.contract_id
  group_id    = var.group_id
  property_id = var.property_id
}

resource "akamai_dns_zone" "tf_demo_zone" {
  contract                 = var.contract_id
  group                    = var.group_id
  zone                     = var.dns_zone
  type                     = "PRIMARY"
  masters                  = []
  comment                  = "-- DO NOT DELETE --"
  sign_and_serve           = false
  sign_and_serve_algorithm = ""
  target                   = ""
  end_customer_id          = ""
}

resource "akamai_dns_record" "tf_demo_NS" {
  zone       = var.dns_zone
  name       = var.dns_zone
  recordtype = "NS"
  target     = var.ns_servers
  ttl        = 86400
}

resource "akamai_dns_record" "tf_demo_SOA" {
  zone          = var.dns_zone
  email_address = var.soa_email
  expiry        = 604800
  name          = var.dns_zone
  name_server   = var.ns_servers[0]
  nxdomain_ttl  = 300
  recordtype    = "SOA"
  refresh       = 3600
  retry         = 600
  target        = []
  ttl           = 86400
}

resource "akamai_dns_record" "tf_demo_AKAMAICDN" {
  zone       = var.dns_zone
  name       = var.dns_zone
  recordtype = "AKAMAICDN"
  target     = [var.edge_hostname]
  ttl        = 20
}

# Remove the ZAM from the list of hostnames becase for the ZAM we already created the AKAMAICDN record above
locals {
  dns_hostnames_no_zam = [for item in var.dns_hostnames : item if item != var.dns_zone]
}

resource "akamai_dns_record" "tf_demo_dns_hostnames" {

  for_each = toset(local.dns_hostnames_no_zam)

  zone       = var.dns_zone
  recordtype = "CNAME"
  ttl        = 60
  target     = [var.edge_hostname]
  name       = each.value
}

# Create a map with the same length as dns_hostnames, otherwise if the resource creation depends on data.akamai_property_hostnames TF can't know how many resources it needs to create before the apply and fails.
locals {
  cert_status_map = {
    for idx, hostname in var.dns_hostnames : hostname => {
      data.akamai_property_hostnames.tf_demo_hostnames.hostnames[idx].cert_status[0].hostname = data.akamai_property_hostnames.tf_demo_hostnames.hostnames[idx].cert_status[0].target
    }
  }
}

resource "akamai_dns_record" "tf_demo_dns_validation" {

  for_each = var.challenge_validations ? local.cert_status_map : {}

  zone       = var.dns_zone
  recordtype = "CNAME"
  ttl        = 60
  target     = [values(each.value)[0]]
  name       = keys(each.value)[0]
}

resource "akamai_dns_record" "tf_demo_dns_records" {

  for_each = var.additional_records

  zone       = var.dns_zone
  recordtype = each.value.recordType
  ttl        = each.value.ttl
  target     = [each.value.target]
  name       = each.value.name
}