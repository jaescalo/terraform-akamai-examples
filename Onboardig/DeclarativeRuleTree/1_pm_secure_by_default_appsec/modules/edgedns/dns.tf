# Get Akamai property hostnames status for challenges for Secure by Default
data "akamai_property_hostnames" "my_hostnames" {
  contract_id = var.contract_id
  group_id    = var.group_id
  property_id = var.property_id
}

resource "akamai_dns_zone" "my_zone" {
    contract = var.contract_id
    group = var.group_id
    zone = var.dns_zone
    type = "PRIMARY"
    masters = []
    comment = "Spin up configuration via Terraform"
    sign_and_serve = true
    sign_and_serve_algorithm = "ECDSA_P256_SHA256"
    target = ""
    end_customer_id = ""
}

resource "akamai_dns_record" "my_NS" {
    zone = var.dns_zone
    name = var.dns_zone
    recordtype = "NS"
    # Example NS servers from Akamai, these will be different per account/contract
    target = ["a1-34.akam.net.", "a13-65.akam.net.", "a14-66.akam.net.", "a20-67.akam.net.", "a26-64.akam.net.", "a7-65.akam.net."]
    ttl = 86400
}

resource "akamai_dns_record" "my_SOA" {
    zone = var.dns_zone
    email_address = "admin.example.com"
    expiry = 604800
    name = var.dns_zone
    name_server = "a1-34.akam.net."
    nxdomain_ttl = 300
    recordtype = "SOA"
    refresh = 3600
    retry = 600
    target = []
    ttl = 86400
}

resource "akamai_dns_record" "my_AKAMAICDN" {
    zone = var.dns_zone
    name = var.dns_zone
    recordtype = "AKAMAICDN"
    target = [ var.edge_hostname ]
    ttl = 20
}

# Remove the ZAM from the list of hostnames becase for the ZAM we already created the AKAMAICDN record above
locals {
  dns_hostnames_no_zam = [for item in var.dns_hostnames : item if item != var.dns_zone]
}

resource "akamai_dns_record" "my_dns_hostnames" {

  for_each = toset(var.dns_hostnames)

  zone       = var.dns_zone
  recordtype = "CNAME"
  ttl        = 60
  target     = [ var.edge_hostname ]
  name       = each.value
}

# Create a map with the same length as dns_hostnames, otherwise if the resource creation depends on data.akamai_property_hostnames TF can't know how many resources it needs to create before the apply and fails.
locals {
  cert_status_map = {
    for idx, hostname in var.dns_hostnames : hostname => {
      data.akamai_property_hostnames.wingmanstrums_hostnames.hostnames[idx].cert_status[0].hostname = data.akamai_property_hostnames.wingmanstrums_hostnames.hostnames[idx].cert_status[0].target
    }
  }
}

resource "akamai_dns_record" "my_dns_validation" {

  for_each = local.cert_status_map

  zone       = var.dns_zone
  recordtype = "CNAME"
  ttl        = 60
  target     = [values(each.value)[0]]
  name       = keys(each.value)[0]
}