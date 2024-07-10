data "akamai_property_rules_builder" "my_property_rule_minimize_payload" {
  rules_v2024_02_12 {
    name                  = "Minimize payload"
    comments              = "Control the settings that reduce the size of the delivered content and decrease the number of bytes sent by your properties. This allows you to cut down the network overhead of your website or API."
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.my_property_rule_compressible_objects.json,
    ]
  }
}

data "akamai_property_rules_builder" "my_property_rule_compressible_objects" {
  rules_v2024_02_12 {
    name                  = "Compressible objects"
    comments              = "Serve gzip compressed content for text-based formats."
    criteria_must_satisfy = "all"
    criterion {
      content_type {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        match_wildcard       = true
        values               = ["application/*javascript*", "application/*json*", "application/*xml*", "application/text*", "application/vnd-ms-fontobject", "application/vnd.microsoft.icon", "application/x-font-opentype", "application/x-font-truetype", "application/x-font-ttf", "font/eot*", "font/opentype", "font/otf", "image/svg+xml", "image/vnd.microsoft.icon", "image/x-icon", "text/*", "application/octet-stream*", "application/x-font-eot*", "font/ttf", "application/font-ttf", "application/font-sfnt", "application/x-tgif", ]
      }
    }
    behavior {
      gzip_response {
        behavior = "ALWAYS"
      }
    }
  }
}
