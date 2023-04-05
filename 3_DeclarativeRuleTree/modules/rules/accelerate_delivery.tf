data "akamai_property_rules_builder" "jaescalo_terraform-prod_rule_accelerate_delivery" {
  rules_v2023_01_05 {
    name                  = "Accelerate delivery"
    is_secure             = false
    comments              = "Control the settings related to improving the performance of delivering objects to your users."
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_origin_connectivity.json,
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_protocol_optimizations.json,
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_prefetching.json,
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_adaptive_acceleration.json,
    ]
  }
}

data "akamai_property_rules_builder" "jaescalo_terraform-prod_rule_origin_connectivity" {
  rules_v2023_01_05 {
    name                  = "Origin connectivity"
    is_secure             = false
    comments              = "Optimize the connection between edge and origin."
    criteria_must_satisfy = "all"
    behavior {
      dns_async_refresh {
        enabled = true
        timeout = "1h"
      }
    }
    behavior {
      timeout {
        value = "5s"
      }
    }
    behavior {
      read_timeout {
        value = "120s"
      }
    }
  }
}

data "akamai_property_rules_builder" "jaescalo_terraform-prod_rule_protocol_optimizations" {
  rules_v2023_01_05 {
    name                  = "Protocol optimizations"
    is_secure             = false
    comments              = "Serve your website using modern and fast protocols."
    criteria_must_satisfy = "all"
    behavior {
      enhanced_akamai_protocol {
        display = ""
      }
    }
    behavior {
      http2 {
        enabled = ""
      }
    }
    behavior {
      allow_transfer_encoding {
        enabled = true
      }
    }
    behavior {
      sure_route {
        enable_custom_key      = false
        enabled                = true
        force_ssl_forward      = false
        race_stat_ttl          = "30m"
        sr_download_link_title = ""
        test_object_url        = "/akamai/sureroute-test-object.html"
        to_host_status         = "INCOMING_HH"
        type                   = "PERFORMANCE"
      }
    }
  }
}

data "akamai_property_rules_builder" "jaescalo_terraform-prod_rule_prefetching" {
  rules_v2023_01_05 {
    name                  = "Prefetching"
    is_secure             = false
    comments              = "Instruct edge servers to retrieve embedded resources before the browser requests them."
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_prefetching_objects.json,
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_prefetchable_objects.json,
    ]
  }
}

data "akamai_property_rules_builder" "jaescalo_terraform-prod_rule_prefetching_objects" {
  rules_v2023_01_05 {
    name                  = "Prefetching objects"
    is_secure             = false
    comments              = "Define for which HTML pages prefetching should be enabled."
    criteria_must_satisfy = "all"
    behavior {
      prefetch {
        enabled = true
      }
    }
    children = [
      data.akamai_property_rules_builder.jaescalo_terraform-prod_rule_bots.json,
    ]
  }
}

data "akamai_property_rules_builder" "jaescalo_terraform-prod_rule_bots" {
  rules_v2023_01_05 {
    name                  = "Bots"
    is_secure             = false
    comments              = "Disable prefetching for specific clients identifying themselves as bots and crawlers. This avoids requesting unnecessary resources from the origin."
    criteria_must_satisfy = "all"
    criterion {
      user_agent {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        match_wildcard       = true
        values               = ["*bot*", "*crawl*", "*spider*", ]
      }
    }
    behavior {
      prefetch {
        enabled = false
      }
    }
  }
}

data "akamai_property_rules_builder" "jaescalo_terraform-prod_rule_prefetchable_objects" {
  rules_v2023_01_05 {
    name                  = "Prefetchable objects"
    is_secure             = false
    comments              = "Define which resources should be prefetched."
    criteria_must_satisfy = "all"
    criterion {
      file_extension {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        values               = ["css", "js", "jpg", "jpeg", "jp2", "png", "gif", "svg", "svgz", "webp", "eot", "woff", "woff2", "otf", "ttf", ]
      }
    }
    behavior {
      prefetchable {
        enabled = true
      }
    }
  }
}

data "akamai_property_rules_builder" "jaescalo_terraform-prod_rule_adaptive_acceleration" {
  rules_v2023_01_05 {
    name                  = "Adaptive acceleration"
    is_secure             = false
    comments              = "Automatically and continuously apply performance optimizations to your website using machine learning."
    criteria_must_satisfy = "all"
    behavior {
      adaptive_acceleration {
        ab_logic                  = "DISABLED"
        enable_brotli_compression = false
        enable_preconnect         = true
        enable_push               = true
        enable_ro                 = false
        preload_enable            = true
        source                    = "mPulse"
        title_http2_server_push   = ""
        title_preconnect          = ""
        title_preload             = ""
        title_ro                  = ""
      }
    }
  }
}