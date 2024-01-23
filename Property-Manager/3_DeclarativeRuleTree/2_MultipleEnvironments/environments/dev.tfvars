# Akamai Provider 

edgerc_location = "~/.edgerc"
edgerc_section  = "tf"

# Common

group_name = "Group Name"

# Edge Hostname

edge_hostname = "tf-dev.com.edgesuite.net"

# Property 

property_name      = "tf-dev.com"
property_hostnames = ["tf-dev.com", "www.tf-dev.com"]
cp_code_name       = "tf-dev"

origin_parameters = {
  hostname           = "tf-dev.download.akamai.com"
  netstorage_cp_code = 123456
  type               = "NET_STORAGE"
}

version_notes = "Initial version"
emails        = ["noreply@akamai.com"]