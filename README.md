# Akamai Terraform Templates
These are some example on how the Akamai Terraform provider can be used to onboard and maintain one or more properties. 

*Keyword(s):* terraform, akamai provider, automation, for_each, modules, workspace<br>

## Prerequisites
- [Akamai API Credentials](https://developer.akamai.com/getting-started/edgegrid) for creating propertie, hostnames and CP codes.
- [Akamai provider version 1.5.1](https://registry.terraform.io/providers/akamai/akamai/1.5.1). For older versions of the provider some of the fields are no longer supported. See the [change log](https://github.com/akamai/terraform-provider-akamai/blob/master/CHANGELOG.md) for the Akamai provider for more details.
- [Akamai Property Manager CLI](https://github.com/akamai/cli-property-manager)
- The examples assume the CP Codes are available before hand because the intention is to manage existing resources on Akamai. However in an onboarding scenario you'll want to create the new CP Codes in the TF code.


## 1 - Monolithic Rule Tree
This is the simplest case where the rule tree is a single JSON file which contains all the rules, match criteria and behaviors.

## 2 - Snippets (JSON)
Breaks down the monolitc rule tree into JSON snippets files which can be managed in an easier way. There are 2 scenarios:

### /ak_templates
Uses the Akamai provider's `akamai_property_rules_template` data source to merge all the JSON snippets into the final rule tree.

### /tf_templates
Uses Hashicorp's `template_file` data source and the `templatefile` together with the JSON snippets and a TF template file that allows for other powerful functions.

## 3 - Use of TF for_each meta-argument 
Allows for deploying multiple resources by iterating through a list of resources to onboard or modify. This is achieved with the `for_each` meta-argument. There are 2 scenarios:

### With JSON Snippets
Relies on passing the parameters to the JSON snippets via the `variables` blocks inside the `akamai_property_rules_template` resource.

### With JSON Snippets and Variables files
Additionally, when using Akamai JSON Snippets, these can be parameterized through variables defined in a `variableDefinitions.json` file and the values added to each environment in the `environments/{env}/variables.json` files.

## 4 - Terraform Workspaces and JSON Snippets
Workspaces allow to reuse the same snippets/templates and *.tf files, and create different state files based on your environments.
You can think of TF Workspaces as branches in a Git repository, where you could test and work on parallel changes before pushing them to production. 

## 5 - Terraform Modules and JSON Snippets
Makes use of TF Modules which provide more flexibility for code reutilization and environment isolation.

### Property Manager (3 Templating Options)
Modules in TF are pieces of code that can be reused by parameterizing them and calling them within our main Terraform code. By practice the modules are created in the `/modules/` folder and they look just like normal HCL.

### Property Full Onboard to Akamai
Onboards a domain to Akamai from scratch: creates certificate, edge hostname, property, dns records and application security configurations.

## Debugging
For debugging you can enable the logging level: OFF, TRACE, DEBUG, INFO, WARN or ERROR
 
`$ export TF_LOG=TRACE`
 
TRACE will give the Akamai outputs.

## More details on Terraform and Akamai Provider
- [Terraform](https://www.terraform.io/)
- [Akamai provider](https://registry.terraform.io/providers/akamai/akamai/latest)
- [Akamai Terraform Examples](https://github.com/akamai/terraform-provider-akamai/tree/master/examples)