# Terraform Modules and JSON Snippets (3 Templating Options)

## 1 - Multiple Properties Using JSON Snippets and TF Modules
**Use Case:** Manage or onboard multiple properties that share the same rule tree structure onto Akamai by using the Akamai Terraform Provider's `akamai_property_rules_template` resource.

## 2 - Multiple Properties with Different Rule Sets Using JSON Snippets and TF Modules
**Use Case:** Manage or onboard multiple properties that have a different rule tree structure onto Akamai by using the Akamai Terraform Provifer's `akamai_property_rules_template` resource. One `main.json` file is required per property as each file will contain the rule tree structure.

## 3 - Multiple Properties with Different Rule Sets Using JSON Snippets and TF Modules
**Use Case:** Manage or onboard multiple properties that have a different rule trees onto Akamai by using the Terraform `template_file` resource instead of the Akamai Provider's `akamai_property_rules_template` resource. When using the `template_file` resource there's a bit more flexibility when building properties that differ in the rules. Also, the template file syntax will change and we'll call the file `main.tfjson` instead of the traditional `main.json`.
