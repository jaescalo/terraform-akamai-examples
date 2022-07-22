# Manage Multiple Properties with JSON Snippets Variable Files and "for_each"
By using the Akamai Property Manager CLI [snippets](https://github.com/akamai/cli-property-manager#property-management-with-snippets-workflow) command a property can be broken down into several json snippet files (one snippet per parent rule by default), which are easier to manage than a single JSON file containing all the rules.

The Akamai Property Manager CLI [pipeline](https://github.com/akamai/cli-property-manager#akamai-pipeline-workflow) command also builds the JSON snippets structure plus a variable file definition and variable files per environments to parameterize your JSON snippets and re-use them for multiple properties. We'll use the pipeline files structure in this example. 

Alternatively, the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate the snippets structure plus it will create the basic `*.tf` files and import script. 

Additionally, with the use of the Terraform's `for_each` meta-argument the code can be re-used to deploy multiple resources in one run.

## Akamai Property JSON Snippets
An existing property to use as baseline can be imported into snippets by submitting the following snippets command:

`$ akamai snippets import -p <PROPERTY-NAME>`

The resulting JSON snippets will be located under the folder PROPERTY-NAME/config-snippets. You can copy these files under a different folder where the TF configuration will reference to. In this example these have been moved to the Terraform project folder as property-snippets/.

## Template Characteristics
* Manage multiple properties. In this example 2 properties named `terraform-dev` and `terraform-prod`.
* Under the `environments` folder there's the `variableDefinition.json` file which defines all the variables used in the JSON snippets. For instance the variables `origin` and `cpcode`:
    ```
    {
        "definitions": {
            "origin": {
                "type": "userVariableValue",
                "default": ""
            },
            "cpcode": {
                "type": "userVariableValue",
                "default": 000000
            }
        }
    }
    ```
    Default values can be entered in this file, or leave them empty to specify them on a per environment basis.
* Inside the `environments` folder is where each property or environment is defined. For example in the `dev` folder there's the `variables.json` which has the actual parameters for the dev environment.
    ```
    {
        "origin": "origin.dev.host.com",
        "cpcode": 000000
    }
    ```
* In your main *.tf file use the data source ["akamai_property_rules_template"](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_template) (introduced in Akamai provider v1.0.0 - Dec9 2020) which lets you configure a rule tree through the use of JSON template files (snippets). You can also keep your Property Manager CLI variable definition files and references (`"${env.<variableName>}"`)

    This is an example use case where the `"${env.cpcode}"` and `"${env.origin}"` are replaced in your JSON snippets by the values defined below and the final rule tree is built.
    The `for_each` meta-argument is used to loop over the `customer_env` variable assigning the environment value for each iteration. 

    ```
    data "akamai_property_rules_template" "rules" {

        for_each = var.customer_env

        template_file       = abspath("${path.module}/property-snippets/main.json")
        var_definition_file = abspath("${path.module}/environments/variableDefinitions.json")
        var_values_file     = abspath("${path.module}/environments/${each.key}/variables.json")
    }
    ```
    Note the use of the `var_definition_file` and `var_values_file` arguments to pass the variables and values to the JSON snippets.
* Similarly the property names and hostnames are controlled by the variable `customer_env` with the use of the `for_each` meta-argument:
    ```
    resource "akamai_property" "my_property" {

        for_each = var.customer_env

        name        = "terraform-${each.key}"
        product_id  = "prd_Fresca"
        contract_id = data.akamai_contract.contract.id
        group_id    = data.akamai_contract.contract.group_id
        hostnames {
            cname_from             = "tf-${each.key}.host.com"
            cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
            cert_provisioning_type = "DEFAULT"
        }
        rule_format = "latest"
        rules       = data.akamai_property_rules_template.rules[each.key].json
    }
    ```

* Finally, the activation also relies on 'customer_env' variable and the `for_each` to activate on each environment:
    ```
    resource "akamai_property_activation" "my_activation" {

        for_each = var.customer_env

        property_id = akamai_property.my_property[each.key].id
        contact     = var.contact
        version     = akamai_property.my_property[each.key].latest_version
        network     = upper(var.network)
    }
    ```

## Import
The `import.sh` file can be used as a reference on how to import existing resources in Akamai into Terraform state. Note that in this example each property import must be labeled differently so that TF can keep track of the different properties. 

The documentation for importing the different resources is found in the official Akamai provider documentation:

- [Import a Property](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property)
- [Import an Edge Hostname](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname#import)