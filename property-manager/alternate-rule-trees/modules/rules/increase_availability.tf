data "akamai_property_rules_builder" "my_property_rule_increase_availability" {
  rules_v2024_02_12 {
    name                  = "Increase availability"
    comments              = "Control how to respond when your origin or third parties are slow or even down to minimize the negative impact on user experience."
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.my_property_rule_simulate_failover.json,
      data.akamai_property_rules_builder.my_property_rule_site_failover.json,
      data.akamai_property_rules_builder.my_property_rule_origin_health.json,
      data.akamai_property_rules_builder.my_property_rule_script_management.json,
    ]
  }
}

data "akamai_property_rules_builder" "my_property_rule_simulate_failover" {
  rules_v2024_02_12 {
    name                  = "Simulate failover"
    comments              = "Simulate an origin connection problem and test the site failover configuration on the CDN staging network."
    criteria_must_satisfy = "all"
    criterion {
      content_delivery_network {
        match_operator = "IS"
        network        = "STAGING"
      }
    }
    criterion {
      request_header {
        header_name                = "breakconnection"
        match_case_sensitive_value = true
        match_operator             = "IS_ONE_OF"
        match_wildcard_name        = false
        match_wildcard_value       = false
        values                     = ["Your-Secret-Here", ]
      }
    }
    behavior {
      break_connection {
        enabled = true
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_site_failover" {
  rules_v2024_02_12 {
    name                  = "Site failover"
    comments              = "Specify how edge servers respond when the origin is not available."
    criteria_must_satisfy = "any"
    criterion {
      origin_timeout {
        match_operator = "ORIGIN_TIMED_OUT"
      }
    }
    behavior {
      fail_action {
        enabled = false
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_origin_health" {
  rules_v2024_02_12 {
    name                  = "Origin health"
    comments              = "Monitor the health of your origin by tracking unsuccessful IP connection attempts."
    criteria_must_satisfy = "all"
    behavior {
      health_detection {
        maximum_reconnects = 3
        retry_count        = 3
        retry_interval     = "10s"
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_script_management" {
  rules_v2024_02_12 {
    name                  = "Script management"
    comments              = "Enable Script Management to minimize performance and availability impacts from third-party JavaScripts."
    criteria_must_satisfy = "all"
    behavior {
      script_management {
        enabled = false
      }
    }
  }
}