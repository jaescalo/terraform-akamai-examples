# Get Akamai property hostnames status for challenges for Secure by Default. This returns an object with all the pending challenges. Since we only have one hostname we'll look for the first item in the object in the akamai_dns_record resource below
data "akamai_property_hostnames" "my_hostnames" {
  contract_id = var.contract_id
  group_id    = var.group_id
  property_id = var.property_id
}

resource "akamai_dns_record" "my_hostnames_to_akamaize" {
  zone       = var.dns_zone
  recordtype = "CNAME"
  ttl        = 60
  target     = [ var.edge_hostname ]
  name       = var.property_hostname
}

resource "akamai_dns_record" "my_hostnames_dns_validation" {
  zone       = var.dns_zone
  recordtype = "TXT"
  ttl        = 60
  target     = [ data.akamai_property_hostnames.my_hostnames.hostnames[0].cert_status[0].target ]
  name       = data.akamai_property_hostnames.my_hostnames.hostnames[0].cert_status[0].hostname  
}
