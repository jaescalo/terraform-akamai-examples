output "hostnames_from_dns" {
  # Builds object that can be consumed by for_each
  value = { for index, hostnames in data.akamai_property_hostnames.tf_demo_hostnames.hostnames : index => hostnames }
}

output "cert_status_map" {
  value = local.cert_status_map
}