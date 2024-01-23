# Declarative Property Manager

In TF provider version 3.5.0 (March 30th 2023) a new way to build and maintain the rules in the property is available. Further documentation coming here soon. For now refer to the official documentation for the `rule_property_rules_builder` resource [HERE](https://techdocs.akamai.com/terraform/docs/rules-builder)

Akamai's Terraform CLI now supports exporting a property to TF using the declarative syntax (HCL). For more information check out the [official CLI repository](https://github.com/akamai/cli-terraform#property-manager-properties).
In summary here's how you would export an existing property to TF with the declarative syntax:
```
akamai terraform export-property --rules-as-hcl <property-name>
```