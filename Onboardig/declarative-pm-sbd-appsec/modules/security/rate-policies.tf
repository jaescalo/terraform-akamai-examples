resource "akamai_appsec_rate_policy" "origin_error" {
  config_id = akamai_appsec_configuration.config.config_id
  rate_policy = jsonencode(
    {
      "additionalMatchOptions" : [
        {
          "positiveMatch" : true,
          "type" : "ResponseStatusCondition",
          "values" : [
            "400",
            "401",
            "402",
            "403",
            "404",
            "405",
            "406",
            "407",
            "408",
            "409",
            "410",
            "500",
            "501",
            "502",
            "503",
            "504"
          ]
        }
      ],
      "averageThreshold" : 5,
      "burstThreshold" : 8,
      "clientIdentifier" : "ip",
      "description" : "An excessive error rate from the origin could indicate malicious activity by a bot scanning the site or a publishing error. In both cases, this would increase the origin traffic and could potentially destabilize it.",
      "matchType" : "path",
      "name" : "Origin Error",
      "pathMatchType" : "Custom",
      "pathUriPositiveMatch" : true,
      "requestType" : "ForwardResponse",
      "sameActionOnIpv6" : true,
      "type" : "WAF",
      "useXForwardForHeaders" : false
    }
  )
}

resource "akamai_appsec_rate_policy" "post_page_requests" {
  config_id = akamai_appsec_configuration.config.config_id
  rate_policy = jsonencode(
    {
      "additionalMatchOptions" : [
        {
          "positiveMatch" : true,
          "type" : "RequestMethodCondition",
          "values" : [
            "POST"
          ]
        }
      ],
      "averageThreshold" : 3,
      "burstThreshold" : 5,
      "clientIdentifier" : "ip",
      "description" : "Mitigating HTTP flood attacks using POST requests",
      "matchType" : "path",
      "name" : "POST Page Requests",
      "pathMatchType" : "Custom",
      "pathUriPositiveMatch" : true,
      "requestType" : "ClientRequest",
      "sameActionOnIpv6" : true,
      "type" : "WAF",
      "useXForwardForHeaders" : false
    }
  )
}

resource "akamai_appsec_rate_policy" "page_view_requests" {
  config_id = akamai_appsec_configuration.config.config_id
  rate_policy = jsonencode(
    {
      "additionalMatchOptions" : [
        {
          "positiveMatch" : false,
          "type" : "RequestMethodCondition",
          "values" : [
            "POST"
          ]
        }
      ],
      "averageThreshold" : 12,
      "burstThreshold" : 18,
      "clientIdentifier" : "ip",
      "description" : "A popular brute force attack that consists of sending a large number of requests for base page, HTML page or XHR requests (usually non-cacheable). This could destabilize the origin.",
      "fileExtensions" : {
        "positiveMatch" : false,
        "values" : [
          "aif",
          "aiff",
          "au",
          "avi",
          "bin",
          "bmp",
          "cab",
          "carb",
          "cct",
          "cdf",
          "class",
          "css",
          "csv",
          "dcr",
          "doc",
          "docx",
          "dtd",
          "ejs",
          "ejss",
          "eot",
          "eps",
          "exe",
          "flv",
          "gcf",
          "gff",
          "gif",
          "grv",
          "hdml",
          "hdp",
          "hqx",
          "ico",
          "ini",
          "jar",
          "jp2",
          "jpeg",
          "jpg",
          "js",
          "jxr",
          "mid",
          "midi",
          "mov",
          "mp3",
          "mp4",
          "nc",
          "ogv",
          "otc",
          "otf",
          "pct",
          "pdf",
          "pict",
          "pls",
          "png",
          "ppc",
          "ppt",
          "pptx",
          "ps",
          "pws",
          "svg",
          "svgz",
          "swa",
          "swf",
          "tif",
          "tiff",
          "ttc",
          "ttf",
          "txt",
          "vbs",
          "w32",
          "wav",
          "wbmp",
          "wdp",
          "webm",
          "webp",
          "wml",
          "wmlc",
          "wmls",
          "wmlsc",
          "woff",
          "woff2",
          "xls",
          "xlsx",
          "xsd",
          "zip"
        ]
      },
      "matchType" : "path",
      "name" : "Page View Requests",
      "pathMatchType" : "Custom",
      "pathUriPositiveMatch" : true,
      "requestType" : "ClientRequest",
      "sameActionOnIpv6" : true,
      "type" : "WAF",
      "useXForwardForHeaders" : false
    }
  )
}

