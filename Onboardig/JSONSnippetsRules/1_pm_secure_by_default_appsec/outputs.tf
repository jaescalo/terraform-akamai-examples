# Output from Property Module
output "contract_id" {
  value = module.akamai_property.contract_id
}

output "group_id" {
  value = module.akamai_property.group_id
}

output "property_id" {
  value = module.akamai_property.property_id
}

# Output from the EdgeDNS Module
output "hostnames_from_dns" {
  value = module.akamai_edgedns_records.hostnames_from_dns
}
