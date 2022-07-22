module "property" {
  source       = "../../modules/property"
  group_name   = "My Group"
  product_id = "prd_Fresca"
  customer_env = "prod"
  property_and_edge_hostnames = [
    {
      property_hostname = "tf-prod.host.com"
      edge_hostname     = "tf-prod.edgesuite.net"
    }
  ]
  contact = ["email@akamai.com"]
  network      = "staging"
}