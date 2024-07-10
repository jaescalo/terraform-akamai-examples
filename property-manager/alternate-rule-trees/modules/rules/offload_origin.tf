data "akamai_property_rules_builder" "my_property_rule_offload_origin" {
  rules_v2024_02_12 {
    name                  = "Offload origin"
    comments              = "Control the settings related to caching content at the edge and in the browser. As a result, fewer requests go to your origin, fewer bytes leave your data centers, and your assets are closer to your users."
    criteria_must_satisfy = "all"
    behavior {
      caching {
        behavior = "NO_STORE"
      }
    }
    behavior {
      tiered_distribution {
        enabled                 = true
        tiered_distribution_map = "CH2"
      }
    }
    behavior {
      validate_entity_tag {
        enabled = false
      }
    }
    behavior {
      remove_vary {
        enabled = false
      }
    }
    behavior {
      cache_error {
        enabled        = true
        preserve_stale = true
        ttl            = "10s"
      }
    }
    behavior {
      cache_key_query_params {
        behavior = "INCLUDE_ALL_ALPHABETIZE_ORDER"
      }
    }
    behavior {
      prefresh_cache {
        enabled     = true
        prefreshval = 90
      }
    }
    behavior {
      downstream_cache {
        allow_behavior = "LESSER"
        behavior       = "ALLOW"
        send_headers   = "CACHE_CONTROL"
        send_private   = false
      }
    }
    children = [
      data.akamai_property_rules_builder.my_property_rule_css_and_java_script.json,
      data.akamai_property_rules_builder.my_property_rule_fonts.json,
      data.akamai_property_rules_builder.my_property_rule_images.json,
      data.akamai_property_rules_builder.my_property_rule_files.json,
      data.akamai_property_rules_builder.my_property_rule_other_static_objects.json,
      data.akamai_property_rules_builder.my_property_rule_html_pages.json,
      data.akamai_property_rules_builder.my_property_rule_redirects.json,
      data.akamai_property_rules_builder.my_property_rule_post_responses.json,
      data.akamai_property_rules_builder.my_property_rule_graph_ql.json,
      data.akamai_property_rules_builder.my_property_rule_uncacheable_objects.json,
    ]
  }
}

data "akamai_property_rules_builder" "my_property_rule_css_and_java_script" {
  rules_v2024_02_12 {
    name                  = "CSS and JavaScript"
    comments              = "Override the default caching behavior for CSS and JavaScript"
    criteria_must_satisfy = "any"
    criterion {
      file_extension {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        values               = ["css", "js", ]
      }
    }
    behavior {
      caching {
        behavior        = "MAX_AGE"
        must_revalidate = false
        ttl             = "7d"
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_fonts" {
  rules_v2024_02_12 {
    name                  = "Fonts"
    comments              = "Override the default caching behavior for fonts."
    criteria_must_satisfy = "any"
    criterion {
      file_extension {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        values               = ["eot", "woff", "woff2", "otf", "ttf", ]
      }
    }
    behavior {
      caching {
        behavior        = "MAX_AGE"
        must_revalidate = false
        ttl             = "30d"
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_images" {
  rules_v2024_02_12 {
    name                  = "Images"
    comments              = "Override the default caching behavior for images."
    criteria_must_satisfy = "any"
    criterion {
      file_extension {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        values               = ["jpg", "jpeg", "png", "gif", "webp", "jp2", "ico", "svg", "svgz", ]
      }
    }
    behavior {
      caching {
        behavior        = "MAX_AGE"
        must_revalidate = false
        ttl             = "30d"
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_files" {
  rules_v2024_02_12 {
    name                  = "Files"
    comments              = "Override the default caching behavior for files. Files containing Personal Identified Information (PII) should require Edge authentication or not be cached at all."
    criteria_must_satisfy = "any"
    criterion {
      file_extension {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        values               = ["pdf", "doc", "docx", "odt", ]
      }
    }
    behavior {
      caching {
        behavior        = "MAX_AGE"
        must_revalidate = false
        ttl             = "7d"
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_other_static_objects" {
  rules_v2024_02_12 {
    name                  = "Other static objects"
    comments              = "Override the default caching behavior for other static objects."
    criteria_must_satisfy = "any"
    criterion {
      file_extension {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        values               = ["aif", "aiff", "au", "avi", "bin", "bmp", "cab", "carb", "cct", "cdf", "class", "dcr", "dtd", "exe", "flv", "gcf", "gff", "grv", "hdml", "hqx", "ini", "mov", "mp3", "nc", "pct", "ppc", "pws", "swa", "swf", "txt", "vbs", "w32", "wav", "midi", "wbmp", "wml", "wmlc", "wmls", "wmlsc", "xsd", "zip", "pict", "tif", "tiff", "mid", "jxr", "jar", ]
      }
    }
    behavior {
      caching {
        behavior        = "MAX_AGE"
        must_revalidate = false
        ttl             = "7d"
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_html_pages" {
  rules_v2024_02_12 {
    name                  = "HTML pages"
    comments              = "Override the default caching behavior for HTML pages cached on edge servers."
    criteria_must_satisfy = "all"
    criterion {
      file_extension {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        values               = ["html", "htm", "php", "jsp", "aspx", "EMPTY_STRING", ]
      }
    }
    behavior {
      caching {
        behavior = "NO_STORE"
      }
    }
    behavior {
      cache_key_query_params {
        behavior    = "IGNORE"
        exact_match = true
        parameters  = ["gclid", "fbclid", "utm_source", "utm_campaign", "utm_medium", "utm_content", ]
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_redirects" {
  rules_v2024_02_12 {
    name                  = "Redirects"
    comments              = "Configure caching for HTTP redirects. The redirect is cached for the same TTL as a 200 HTTP response when this feature is enabled."
    criteria_must_satisfy = "all"
    behavior {
      cache_redirect {
        enabled = "false"
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_post_responses" {
  rules_v2024_02_12 {
    name                  = "POST responses"
    comments              = "Define when HTTP POST requests should be cached. You should enable it under a criteria match."
    criteria_must_satisfy = "all"
    behavior {
      cache_post {
        enabled = false
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_graph_ql" {
  rules_v2024_02_12 {
    name                  = "GraphQL"
    comments              = "Define when your GraphQL queries should be cached."
    criteria_must_satisfy = "all"
    criterion {
      path {
        match_case_sensitive = false
        match_operator       = "MATCHES_ONE_OF"
        normalize            = false
        values               = ["/graphql", ]
      }
    }
    behavior {
      graphql_caching {
        enabled = false
      }
    }
  }
}

data "akamai_property_rules_builder" "my_property_rule_uncacheable_objects" {
  rules_v2024_02_12 {
    name                  = "Uncacheable objects"
    comments              = "Configure the default client caching behavior for uncacheable content at the edge."
    criteria_must_satisfy = "all"
    criterion {
      cacheability {
        match_operator = "IS_NOT"
        value          = "CACHEABLE"
      }
    }
    behavior {
      downstream_cache {
        behavior = "BUST"
      }
    }
  }
}
