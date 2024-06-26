terraform {
  required_providers {
    akamai = {
      source = "akamai/akamai"
      version = "= 5.5.0"
    }
  }
}

# Used to read the contract ID based on the provided group name, it can also return the group id.
data "akamai_contract" "contract" {
  group_name = var.group_name
}

# Create an edge hostname that uses this certificate
resource "akamai_edge_hostname" "edge_hostname" {
  product_id    = var.product_id
  contract_id   = data.akamai_contract.contract.id
  group_id      = data.akamai_contract.contract.group_id
  edge_hostname = var.edge_hostname
  ip_behavior   = var.ip_behavior
  certificate   = var.certificate
}