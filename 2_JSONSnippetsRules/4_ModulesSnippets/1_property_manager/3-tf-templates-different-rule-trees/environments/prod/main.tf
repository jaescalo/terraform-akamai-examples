module "property" {
  source       = "../../modules/property"
  network      = "staging"
  customer_env = "prod"
  property_and_edge_hostnames = [
    {
      property_hostname = "tf-prod.host.com"
      edge_hostname     = "tf-prod.edgesuite.net"
    }
  ]
  comments = "Managed by Terraform"
  origin = "origin.dev.host.com"
  cpcode = "1111111"
  contact = ["email@akamai.com"]
}