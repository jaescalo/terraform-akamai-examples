network  = "staging"
contact  = ["email@akamai.com"]
origin   = "my.origin.com"
comments = "Activation from Terraform"

property_and_edge_hostnames = [{
  property_hostname = "tf-demo.host1.com"
  edge_hostname     = "tf-demo.edgesuite.net"
  },
  {
    property_hostname = "tf-demo.host2.com"
    edge_hostname     = "tf-demo.edgesuite.net"
}]
