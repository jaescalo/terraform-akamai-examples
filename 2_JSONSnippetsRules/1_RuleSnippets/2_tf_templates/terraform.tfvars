network  = "staging"
contact  = ["email@akamai.com"]
origin   = "my.origin.com"
comments = "Activation from Terraform"

origin_default_cn_list = [
  "{{Origin Hostname}}",
  "{{Forward Host Header}}",
  "alternate-tf-demo.host.com"
]

property_and_edge_hostnames = [{
  property_hostname = "tf-demo.host1.com"
  edge_hostname     = "tf-demo.edgesuite.net"
  },
  {
    property_hostname = "tf-demo.host2.com"
    edge_hostname     = "tf-demo.edgesuite.net"
}]
