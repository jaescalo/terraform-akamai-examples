
terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = ">= 2.0.0"
    }
  }
}


data "akamai_property_rules_builder" "jaescalo_terraform-prod_rule_default" {
  rules_v2023_01_05 {
    name      = "default"
    is_secure = false
    comments  = "The Default Rule template contains all the necessary and recommended behaviors. Rules are evaluated from top to bottom and the last matching rule wins."
    variable {
      name        = "PMUSER_ORIGIN"
      description = ""
      value       = "dummy.origin.com"
      hidden      = false
      sensitive   = false
    }
    behavior {
      origin {
        cache_key_hostname            = "REQUEST_HOST_HEADER"
        compress                      = true
        enable_true_client_ip         = true
        forward_host_header           = "REQUEST_HOST_HEADER"
        hostname                      = var.origin_server
        http_port                     = 80
        https_port                    = 443
        ip_version                    = "IPV4"
        origin_certificate            = ""
        origin_sni                    = true
        origin_type                   = "CUSTOMER"
        ports                         = ""
        true_client_ip_client_setting = false
        true_client_ip_header         = "True-Client-IP"
        verification_mode             = "PLATFORM_SETTINGS"
      }
    }
    children = [
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_augment_insights.json,
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_accelerate_delivery.json,
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_offload_origin.json,
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_strengthen_security.json,
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_increase_availability.json,
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_minimize_payload.json,
    ]
  }
}
