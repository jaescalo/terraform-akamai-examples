output "hostnames_from_dns" {
  # Builds object that can be consumed by for_each
  value = { for index, hostnames in data.akamai_property_hostnames.my_hostnames.hostnames : index => hostnames }
}