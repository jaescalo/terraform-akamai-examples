# Manage Multiple Properties with JSON Snippets and "for_each"

The `for_each` meta argument provides a way to iterate over multiple values to instantiate different TF resource blocks. For example if you have a resource named `akamai-property` you can reuse this block with `for_each` and deploy multiple properties with it. 

This method is a quick  an easy way for onboarding multiple resources with little effort. May not be so convenient to maintain the resources because it will store everything under a single **state file**.

The 2 examples in this repository use different template engines.
* **Multiple Envs**: relies on passing the parameters to the JSON snippets via the `variables` blocks inside the `akamai_property_rules_template` resource.
    ```
    data "akamai_property_rules_template" "rules" {

    for_each = var.properties

    template_file = abspath("${path.root}/property-snippets/main.json")
    variables {
        name  = "cpcode"
        value = each.value.cpcode
        type  = "number"
        }
    variables {
        name  = "origin"
        value = each.value.origin
        type  = "string"
        }
    }
    ```
* **Multiple Envs Var Files**: relies on passing the parameters to the JSON snippets via the `var_definition_file` and `var_values_file` arguments in the `akamai_property_rules_template` resource.

    ```
    data "akamai_property_rules_template" "rules" {

    for_each = var.customer_env

    template_file       = abspath("${path.module}/property-snippets/main.json")
    var_definition_file = abspath("${path.module}/environments/variableDefinitions.json")
    var_values_file     = abspath("${path.module}/environments/${each.key}/variables.json")
    }
    ```