resource "akamai_appsec_custom_rule" "bad_user_agent_60286964" {
  config_id = akamai_appsec_configuration.config.config_id
  custom_rule = jsonencode(
    {
      "conditions" : [
        {
          "positiveMatch" : true,
          "type" : "pathMatch",
          "value" : [
            "/*"
          ],
          "valueCase" : false,
          "valueIgnoreSegment" : true,
          "valueNormalize" : false,
          "valueWildcard" : true
        },
        {
          "name" : [
            "User-Agent"
          ],
          "nameWildcard" : true,
          "positiveMatch" : true,
          "type" : "requestHeaderMatch",
          "value" : [
            "Mozilla/5.0 (Linux; U; Android 3.0; en-us; Xoom Build/HRI39) AppleWebKit/534.13 (KHTML, like Gecko) Version/4.0 Safari/534.13",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36"
          ],
          "valueCase" : false,
          "valueWildcard" : true
        }
      ],
      "description" : "Blocklist Bad User Agent",
      "name" : "Blocklist Bad User Agent",
      "operation" : "AND",
      "tag" : [
        "demo"
      ]
    }
  )
}

