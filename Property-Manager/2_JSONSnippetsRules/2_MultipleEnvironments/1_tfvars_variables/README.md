# Manage Multiple Properties with JSON Snippets
By using the Akamai Property Manager CLI [snippets](https://github.com/akamai/cli-property-manager#property-management-with-snippets-workflow) command a property can be broken down into several json snippet files (one snippet per parent rule by default), which are easier to manage than a single JSON file containing all the rules.
Alternatively, the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate the snippets structure plus it will create the basic `*.tf` files and import script. 

## Akamai Property JSON Snippets
An existing property to use as baseline can be imported into snippets by submitting the following snippets command:

`$ akamai snippets import -p <PROPERTY-NAME>`

The resulting JSON snippets will be located under the folder PROPERTY-NAME/config-snippets. You can copy these files under a different folder where the TF configuration will reference to. In this example these have been moved to the Terraform project folder as property-snippets/.

## Template Characteristics
* Manage multiple properties. In this example 2 properties named `terraform-dev` and `terraform-prod`.
* The variable `property` is an object which which can have multiple elements (e.g. origin, cp code, name, etc)
* The definition of the parameters for each property is stored in the *.tfvars files under `/environments`
    ```
    variable "property" {
        type = object({
            name     = string
            cpcode   = string
            origin   = string
            hostname = string
        })
    }
    ```

    And here's how it would look like in the `/environments/dev.tfvars`:
    ```
    property = {
            name     = "terraform-dev"
            cpcode   = "000000"
            origin   = "origin.dev.host.com"
            hostname = "tf-dev.host.com"
    }
    ```
    
* In your main *.tf file use the data source ["akamai_property_rules_template"](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_template) (introduced in Akamai provider v1.0.0 - Dec9 2020) which lets you configure a rule tree through the use of JSON template files (snippets). You can also keep your Property Manager CLI variable definition files and references (`"${env.<variableName>}"`)

    This is an example use case where the `"${env.cpcode}"` and `"${env.origin}"` are replaced in your JSON snippets by the values defined below and the final rule tree is built.

    ```
    data "akamai_property_rules_template" "rules" {

        template_file = abspath("${path.module}/property-snippets/main.json")
        variables {
            name  = "cpcode"
            value = var.property.cpcode
            type  = "number"
        }
        variables {
            name  = "origin"
            value = var.property.origin
            type  = "string"
        }
    }
    ```

* Similarly the property names and hostnames are added from the variable `property`:
    ```
    resource "akamai_property" "my_property" {
        name        = var.property.name
        product_id  = "prd_SPM"
        contract_id = data.akamai_contract.contract.id
        group_id    = data.akamai_contract.contract.group_id
        hostnames {
            cname_from             = var.property.hostname
            cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
            cert_provisioning_type = "DEFAULT"
        }
        rule_format = "latest"
        rules       = data.akamai_property_rules_template.rules.json
    }
    ```
    
* Finally, for the activation resource:
    ```
    resource "akamai_property_activation" "my_activation" {
        property_id = akamai_property.my_property.id
        contact     = var.contact
        version     = akamai_property.my_property.latest_version
        network     = upper(var.network)
    }
    ```

## Terraform plan/apply
To plan/apply a specific environment:

`$ terraform plan -var-file=./environments/dev.tfvars`

### State File Implications
Because the Terraform excecution occurs at the root level then the default state file would be used for any of the environments causing destroys and recreations when switching from one env to another. To avoid this a remote backend can be configured to store each state file under a unique name/key (e.g. dev-terraform.tfstate, prod-terraform.tfstate).
Alternatively other mechanisms could be used in conjunction:
* Terraform Workspaces (not supported by all remote backends)
* Terraform Modules

## Import
The `import.sh` file can be used as a reference on how to import existing resources in Akamai into Terraform state. Note that in this example each property import must be labeled differently so that TF can keep track of the different properties. 

The documentation for importing the different resources is found in the official Akamai provider documentation:

- [Import a Property](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property)
- [Import an Edge Hostname](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname#import)