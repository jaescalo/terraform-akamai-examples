# Declarative Property Manager

In TF provider version 3.5.0 (March 30th 2023) a new way to build and maintain the rules in the property is available. Further documentation coming here soon. For now refer to the official documentation for the `rule_property_rules_builder` resource [HERE](https://techdocs.akamai.com/terraform/docs/rules-builder)

Akamai's Terraform CLI now supports exporting a property to TF using the declarative syntax (HCL). For more information check out the [official CLI repository](https://github.com/akamai/cli-terraform#property-manager-properties).
In summary here's how you would export an existing property to TF with the declarative syntax:
```
akamai terraform export-property --rules-as-hcl <property-name>
```

## Example Use Case
With Property Manager as HCL many oppotunities open to create more business logic and more complex logic. In this example the code allows for the user to input either a "CUSTOMER" origin or "NETSTORAGE" origin, and the TF code will handle the configuration for either case.


## Terraform plan/apply
To plan/apply a specific environment:

`$ terraform plan -var-file=./environments/dev.tfvars`

### State File Implications
Because the Terraform excecution occurs at the root level then the default state file would be used for any of the environments causing destroys and recreations when switching from one env to another. To avoid this a remote backend can be configured to store each state file under a unique name/key (e.g. dev-terraform.tfstate, prod-terraform.tfstate).
Alternatively other mechanisms could be used in conjunction:
* Terraform Workspaces (not supported by all remote backends)
* Terraform Modules



The documentation for importing the different resources is found in the official Akamai provider documentation:

- [Import a Property](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property)
- [Import an Edge Hostname](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname#import)