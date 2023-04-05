# Demo #6

provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

data "akamai_contract" "contract" {
  group_name = var.group_name
}

data "template_file" "rules" {
  template = templatefile("../../property-snippets/main.tfjson", {
    global_templates_path = "../../property-snippets"
    env_specific_templates_path = "../../property-snippets/${var.customer_env}"
    customer_env = var.customer_env
    comments = var.comments
    origin = var.origin
  })

  # Variables for the rest of the JSON snippets
  vars = {
    cpcode = var.cpcode
  }
}

resource "akamai_property" "my_property" {
  name        = "terraform-${var.customer_env}"
  product_id  = var.product_id
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_contract.contract.group_id

  dynamic "hostnames" {
    for_each = var.property_and_edge_hostnames

    content {
      cname_from             = hostnames.value.property_hostname
      cname_to               = hostnames.value.edge_hostname
      cert_provisioning_type = "DEFAULT"
    }
  }
  rule_format = "latest"
  rules       = data.template_file.rules.rendered
}

resource "akamai_property_activation" "my_activation" {
  property_id = akamai_property.my_property.id
  contact     = var.contact
  version     = akamai_property.my_property.latest_version
  network     = upper(var.network)
}
