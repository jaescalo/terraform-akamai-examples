# Akamai Provider 

edgerc_location = "~/.edgerc"
edgerc_section  = "tf"

# Common

group_name = "Group Name"

# Edge Hostname

edge_hostname = "tf-prod.com.edgesuite.net"

# Property 

property_name      = "tf-prod.com"
property_hostnames = ["tf-prod.com", "www.tf-prod.com"]
cp_code_name       = "tf-prod"

origin_parameters = {
  hostname           = "origin.tf-prod.com"
  netstorage_cp_code = null
  type               = "CUSTOMER"
}

version_notes = "Initial version"
emails        = ["noreply@akamai.com"]
