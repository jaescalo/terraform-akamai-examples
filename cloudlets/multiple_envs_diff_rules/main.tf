locals {
  match_rules_default_json = jsondecode(data.akamai_cloudlets_edge_redirector_match_rule.match_rules_er_default.json)
  match_rules_dev_json     = jsondecode(data.akamai_cloudlets_edge_redirector_match_rule.match_rules_er_dev.json)
  match_rules_qa_json      = jsondecode(data.akamai_cloudlets_edge_redirector_match_rule.match_rules_er_qa.json)
  match_rules_test_json    = jsondecode(data.akamai_cloudlets_edge_redirector_match_rule.match_rules_er_test.json)

  merged_match_rules = {
    dev = concat(local.match_rules_default_json, local.match_rules_dev_json),
    qa = concat(local.match_rules_default_json, local.match_rules_qa_json),
    test = concat(local.match_rules_default_json, local.match_rules_test_json)
  }
}

# For verification or further use, you can output the merged JSON
# output "merged_json_output" {
#   value = jsonencode(lookup(local.merged_match_rules, var.environment))
# }

data "akamai_contract" "contract" {
  group_name = var.group_name
}


resource "akamai_cloudlets_policy" "policy" {
  name          = var.policy_name
  cloudlet_code = var.cloudlet_code
  description   = var.description
  group_id      = data.akamai_contract.contract.group_id
  match_rules   = jsonencode(lookup(local.merged_match_rules, var.environment))
  is_shared     = true
}

resource "akamai_cloudlets_policy_activation" "policy_activation" {
  policy_id = tonumber(akamai_cloudlets_policy.policy.id)
  network   = var.network
  version   = akamai_cloudlets_policy.policy.version
}
