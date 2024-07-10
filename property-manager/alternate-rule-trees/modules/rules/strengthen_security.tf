data "akamai_property_rules_builder" "my_property_rule_strengthen_security" {
  rules_v2024_02_12 {
    name                  = "Strengthen security"
    comments              = "Control the settings that minimize the information your website shares with clients and malicious entities to reduce your exposure to threats."
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.my_property_rule_allowed_methods.json,
      data.akamai_property_rules_builder.my_property_rule_obfuscate_debug_info.json,
      data.akamai_property_rules_builder.my_property_rule_obfuscate_backend_info.json,
      data.akamai_property_rules_builder.my_property_rule_hsts.json,
    ]
  }
}

data "akamai_property_rules_builder" "my_property_rule_allowed_methods" {
  rules_v2024_02_12 {
    name                  = "Allowed methods"
    comments              = "Allow the use of HTTP methods. Consider enabling additional methods under a path match for increased origin security."
    criteria_must_satisfy = "all"
    behavior {
      all_http_in_cache_hierarchy {
        enabled = true
      }
    }
    children = [
      data.akamai_property_rules_builder.my_property_rule_post.json,
      data.akamai_property_rules_builder.my_property_rule_options.json,
      data.akamai_property_rules_builder.my_property_rule_put.json,
      data.akamai_property_rules_builder.my_property_rule_delete.json,
      data.akamai_property_rules_builder.my_property_rule_patch.json,
    ]
  }
}

data "akamai_property_rules_builder" "my_property_rule_obfuscate_debug_info" {
  rules_v2024_02_12 {
    name                  = "Obfuscate debug info"
    comments              = "Do not expose back-end information unless the request contains the Pragma debug header."
    criteria_must_satisfy = "all"
    behavior {
      cache_tag_visible {
        behavior = "PRAGMA_HEADER"
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_obfuscate_backend_info" {
  rules_v2024_02_12 {
    name                  = "Obfuscate backend info"
    comments              = "Do not expose back-end information unless the request contains an additional secret header. Regularly change the criteria to use a specific unique value for the secret header."
    criteria_must_satisfy = "all"
    criterion {
      request_header {
        header_name                = "X-Akamai-Debug"
        match_case_sensitive_value = true
        match_operator             = "IS_NOT_ONE_OF"
        match_wildcard_name        = false
        match_wildcard_value       = false
        values                     = ["true", ]
      }
    }
    behavior {
      modify_outgoing_response_header {
        action                      = "DELETE"
        custom_header_name          = "X-Powered-By"
        standard_delete_header_name = "OTHER"
      }
    }
    behavior {
      modify_outgoing_response_header {
        action                      = "DELETE"
        custom_header_name          = "Server"
        standard_delete_header_name = "OTHER"
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_hsts" {
  rules_v2024_02_12 {
    name                  = "HSTS"
    comments              = "Require all browsers to connect to your site using HTTPS."
    criteria_must_satisfy = "all"
    behavior {
      http_strict_transport_security {
        enable = false
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_post" {
  rules_v2024_02_12 {
    name                  = "POST"
    comments              = "Allow use of the POST HTTP request method."
    criteria_must_satisfy = "all"
    behavior {
      allow_post {
        allow_without_content_length = false
        enabled                      = true
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_options" {
  rules_v2024_02_12 {
    name                  = "OPTIONS"
    comments              = "Allow use of the OPTIONS HTTP request method."
    criteria_must_satisfy = "all"
    behavior {
      allow_options {
        enabled = true
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_put" {
  rules_v2024_02_12 {
    name                  = "PUT"
    comments              = "Allow use of the PUT HTTP request method."
    criteria_must_satisfy = "all"
    behavior {
      allow_put {
        enabled = false
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_delete" {
  rules_v2024_02_12 {
    name                  = "DELETE"
    comments              = "Allow use of the DELETE HTTP request method."
    criteria_must_satisfy = "all"
    behavior {
      allow_delete {
        enabled = false
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_patch" {
  rules_v2024_02_12 {
    name                  = "PATCH"
    comments              = "Allow use of the PATCH HTTP request method."
    criteria_must_satisfy = "all"
    behavior {
      allow_patch {
        enabled = false
      }
    }
  }
}