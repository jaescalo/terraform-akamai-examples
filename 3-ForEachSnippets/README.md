# Manage Multiple Properties with JSON Snippets and "for_each"
By using the Akamai Property Manager CLI [snippets](https://github.com/akamai/cli-property-manager#property-management-with-snippets-workflow) command a property can be broken down into several json snippet files (one snippet per parent rule by default), which are easier to manage than a single JSON file containing all the rules.
Alternatively, the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate the snippets structure plus it will create the basic `*.tf` files and import script. 

Additionally, with the use of the Terraform's `for_each` meta-argument the code can be re-used to deploy multiple resources in one run.

## Akamai Property JSON Snippets
An existing property to use as baseline can be imported into snippets by submitting the following snippets command:

`$ akamai snippets import -p <PROPERTY-NAME>`

The resulting JSON snippets will be located under the folder PROPERTY-NAME/config-snippets. You can copy these files under a different folder where the TF configuration will reference to. In this example these have been moved to the Terraform project folder as property-snippets/.

## Template Characteristics
* Manage multiple properties. In this example 2 properties named `terraform-dev` and `terraform-prod`.
* Variables defined in the `variables.tf` file and their values set in the `terraform.tfvars` file.
* The variable `properties` is an object which can have multiple sets of values. Each set of values can be assigned to each individual property, therefore creating multiple properties with similar rules structure in one go. This is the variable definition in the `variables.tf`:
    ```
    variable "properties" {
        type = map(object({
            cpcode   = string
            origin   = string
            hostname = string
        }))
    }
    ```

    And here's how it would look like for 2 properties in the `terraform.tfvars`:
    ```
    properties = {
        "terraform-dev" = {
            cpcode   = "000000"
            origin   = "origin.dev.host.com"
            hostname = "tf-dev.host.com"
        },
        "terraform-prod" = {
            cpcode   = "111111"
            origin   = "origin.prod.host.com"
            hostname = "tf-prod.host.com"
        },
    }
    ```
    
* In your main *.tf file use the data source ["akamai_property_rules_template"](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_template) (introduced in Akamai provider v1.0.0 - Dec9 2020) which lets you configure a rule tree through the use of JSON template files (snippets). You can also keep your Property Manager CLI variable definition files and references (`"${env.<variableName>}"`)

    This is an example use case where the `"${env.cpcode}"` and `"${env.origin}"` are replaced in your JSON snippets by the values defined below and the final rule tree is built.
    The `for_each` meta-argument is used to loop over the `properties` variable assigning the `cpcode` and `origin` values for each iteration.

    ```
    data "akamai_property_rules_template" "rules" {

        for_each = var.properties

        template_file = abspath("${path.module}/property-snippets/main.json")
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

* Similarly the property names and hostnames are added by the variable `properties` with the use of the `for_each` meta-argument:
    ```
    resource "akamai_property" "my_property" {

        for_each = var.properties

        name        = each.key
        product_id  = "prd_SPM"
        contract_id = data.akamai_contract.contract.id
        group_id    = data.akamai_contract.contract.group_id
        hostnames {
            cname_from             = each.value.hostname
            cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
            cert_provisioning_type = "DEFAULT"
        }
        rule_format = "latest"
        rules       = data.akamai_property_rules_template.rules[each.key].json
    }
    ```
    For the resource “akamai_property” observe the property name is just the key (`each.key`). And that the edge hostname (`cname_to`) now is built based on the parameters for the current iteration (`each.key`). The same goes for the `“rules”` setting.
    Then under each block (`akamai_property_rules_template` and `akamai_edge_hostname`) the actual values are referenced, for example for the origin the name would be set as `each.value.origin` and so on.
    
* Finally, the activation also relies on the `for_each` to activate on each iteration:
    ```
        resource "akamai_property_activation" "my_activation" {

        for_each = var.properties

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