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

resource "akamai_dns_record" "my_dns_hostnames" {

  for_each = toset(var.dns_hostnames)

  zone       = var.dns_zone
  recordtype = "CNAME"
  ttl        = 60
  target     = [ var.edge_hostname ]
  name       = each.value
}

resource "akamai_dns_record" "my_dns_validation" {

  # This error will come up the first time: The "for_each" map includes keys derived from resource attributes that cannot be determined until apply, and so Terraform cannot determine the full set of keys that will identify the instances of this resource.
  
  # When working with unknown values in for_each, it's better to define the map keys statically in your configuration and place apply-time results only in the map values.
  
  # Alternatively, you could use the -target planning option to first apply only the resources that the for_each value depends on, and then apply a second time to fully converge.

  # As suggested the alternative is to use the -target=module.akamai_property option in the tf plan/apply command

  for_each = {
    for h in data.akamai_property_hostnames.my_hostnames.hostnames :
    h.cert_status[0].hostname => h.cert_status[0].target
  }

  zone       = var.dns_zone
  recordtype = "CNAME"
  ttl        = 60
  target     = [each.value]
  name       = each.key
}