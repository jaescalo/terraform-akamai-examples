data "akamai_property_rules_builder" "my_property_rule_augment_insights" {
  rules_v2024_02_12 {
    name                  = "Augment insights"
    comments              = "Control the settings related to monitoring and reporting. This gives you additional visibility into your traffic and audiences."
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.my_property_rule_traffic_reporting.json,
      data.akamai_property_rules_builder.my_property_rule_m_pulse_rum.json,
      data.akamai_property_rules_builder.my_property_rule_geolocation.json,
      data.akamai_property_rules_builder.my_property_rule_log_delivery.json,
    ]
  }
}

data "akamai_property_rules_builder" "my_property_rule_traffic_reporting" {
  rules_v2024_02_12 {
    name                  = "Traffic reporting"
    comments              = "Identify your main traffic segments so you can granularly zoom in your traffic statistics like hits, bandwidth, offload, response codes, and errors."
    criteria_must_satisfy = "all"
    behavior {
      cp_code {
        value {
          id = var.cp_code
        }
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_m_pulse_rum" {
  rules_v2024_02_12 {
    name                  = "mPulse RUM"
    comments              = "Collect and analyze real-user data to monitor the performance of your website."
    criteria_must_satisfy = "all"
    behavior {
      m_pulse {
        api_key         = ""
        buffer_size     = ""
        config_override = ""
        enabled         = true
        loader_version  = "V12"
        require_pci     = false
        title_optional  = ""
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_geolocation" {
  rules_v2024_02_12 {
    name                  = "Geolocation"
    comments              = "Receive data about a user's geolocation and connection speed in a request header. If you change cached content based on the values of the X-Akamai-Edgescape request header, contact your account representative."
    criteria_must_satisfy = "all"
    criterion {
      request_type {
        match_operator = "IS"
        value          = "CLIENT_REQ"
      }
    }
    behavior {
      edge_scape {
        enabled = false
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_log_delivery" {
  rules_v2024_02_12 {
    name                  = "Log delivery"
    comments              = "Specify the level of detail you want to be logged in your Log Delivery Service reports. Log User-Agent Header to obtain detailed information in the Traffic by Browser and OS report."
    criteria_must_satisfy = "all"
    behavior {
      report {
        log_accept_language  = false
        log_cookies          = "OFF"
        log_custom_log_field = false
        log_edge_ip          = false
        log_host             = false
        log_referer          = false
        log_user_agent       = false
        log_x_forwarded_for  = false
      }
    }
  }
}