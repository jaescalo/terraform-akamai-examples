terraform {
  required_providers {
    akamai = {
      source = "akamai/akamai"
      version = "= 6.2.0"
    }
  }
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



resource "akamai_dns_record" "tf_demo_dns_hostnames" {

  count = length(var.dns_hostnames)

  zone       = var.dns_zone
  recordtype = "CNAME"
  ttl        = 60
  target     = [var.edge_hostname]
  name       = var.dns_hostnames[count.index]
}


resource "akamai_dns_record" "tf_demo_dns_records" {

  for_each = var.additional_records

  zone       = var.dns_zone
  recordtype = each.value.recordType
  ttl        = each.value.ttl
  target     = [each.value.target]
  name       = each.value.name
  depends_on = [ 
    akamai_dns_record.tf_demo_dns_hostnames 
  ]
}