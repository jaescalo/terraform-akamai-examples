output "hostnames" {
  value = akamai_property.my_property.hostnames
}

# Shows only the DNS CNAME challenge targets for "Secure by Default"
output "hostname_challenges" {
  value = [for target in akamai_property.my_property.hostnames : target.cert_status[*]]
}