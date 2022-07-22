module "property" {
  source       = "../../modules/property"
  network      = "staging"
  customer_env = "dev"
  property_and_edge_hostnames = [
    {
      property_hostname = "tf-dev.host.com"
      edge_hostname     = "tf-dev.edgesuite.net"
    }
  ]
  comments = "Managed by Terraform"
  origin = "origin.dev.host.com"
  cpcode = "0000000"
  contact = ["email@akamai.com"]
}