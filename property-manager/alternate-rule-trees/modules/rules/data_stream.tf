data "akamai_property_rules_builder" "my_property_rule_data_stream" {
  rules_v2024_02_12 {
    name                  = "DataStream SumoLogic"
    criteria_must_satisfy = "all"
    behavior {
      datastream {
        collect_midgress_traffic = true
        log_enabled              = true
        log_stream_name          = ["73500", ]
        log_stream_title         = ""
        sampling_percentage      = 100
        stream_type              = "LOG"
      }
    }
  }
}