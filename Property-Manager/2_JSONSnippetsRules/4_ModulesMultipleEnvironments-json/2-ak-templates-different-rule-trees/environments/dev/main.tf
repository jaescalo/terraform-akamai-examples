module "property" {
  source       = "../../modules/property"
  group_name   = "My Group"
  product_id   = "prd_Fresca"
  customer_env = "dev"
  property_and_edge_hostnames = [
    {
      property_hostname = "tf-dev.host.com"
      edge_hostname     = "tf-dev.edgesuite.net"
    }
  ]
  contact = ["email@akamai.com"]
  network = "staging"

}