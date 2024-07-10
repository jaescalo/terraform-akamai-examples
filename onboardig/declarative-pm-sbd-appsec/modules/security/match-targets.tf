resource "akamai_appsec_match_target" "website_8232297" {
  config_id = akamai_appsec_configuration.config.config_id
  match_target = jsonencode(
    {
      "defaultFile" : "NO_MATCH",
      "filePaths" : [
        "/*"
      ],
      "hostnames" : [
        "github-workflow.dev.tf-demo.com",
        "github-workflow.prod.tf-demo.com",
        "github-workflow.qa.tf-demo.com"
      ],
      "isNegativeFileExtensionMatch" : false,
      "isNegativePathMatch" : false,
      "securityPolicy" : {
        "policyId" : akamai_appsec_security_policy.tfdemo.security_policy_id
      },
      "sequence" : 0,
      "type" : "website"
    }
  )
}
