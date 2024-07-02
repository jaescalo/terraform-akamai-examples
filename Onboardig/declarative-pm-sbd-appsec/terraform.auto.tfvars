# Common Variables

group_name = "Demos - Templates"
email      = "noreply@akamai.com"

# Domain/Hostnames

domain        = "tf-demo.com"
hostnames     = ["tf-demo.com", "www.tf-demo.com"]
edge_hostname = "tf-demo.com.edgesuite.net"

# Property 

product_id   = "Fresca"
cp_code_name = "Ion Terraform Demo"
origin_hostname = "origin.tf-demo.com"
version_notes                   = "Initial version"
activate_property_on_staging    = false
activate_property_on_production = false

# DNS (Order must be the same as provided in ACC)

ns_servers = ["a1-91.akam.net.", "a13-64.akam.net.", "a20-65.akam.net.", "a22-66.akam.net.", "a24-67.akam.net.", "a9-64.akam.net."]
soa_email  = "noreply.akamai.com"
additional_records = {
  "record1" = {
    recordType = "A"
    ttl        = 60
    target     = "172.233.190.92"
    name       = "origin.tf-demo.com"
  }
}
challenge_validations = true

# Security

appsec_config_name            = "tf-demo-appsec"
appsec_config_description     = "DO NOT DELETE"
appsec_activation_note        = "Initial version"
activate_appsec_on_staging    = true
activate_appsec_on_production = true