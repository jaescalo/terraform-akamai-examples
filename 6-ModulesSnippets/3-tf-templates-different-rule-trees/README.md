# Multiple Properties with Different Rule Sets Using JSON Snippets and TF Modules

**Use Case:** Manage or onboard multiple properties that have a different rule trees onto Akamai by using the Terraform `template_file` resource instead of the Akamai Provider's `akamai_property_rules_template` resource. When using the `template_file` resource there's a bit more flexibility when building properties that differ in the rules. Also, the template file syntax will change and we'll call the file `main.tfjson` instead of the traditional `main.json`.

By using the Akamai Property Manager CLI [snippets](https://github.com/akamai/cli-property-manager#property-management-with-snippets-workflow) command a property can be broken down into several json snippet files (one snippet per parent rule by default), which are easier to manage than a single JSON file containing all the rules.

The Akamai Property Manager CLI [pipeline](https://github.com/akamai/cli-property-manager#akamai-pipeline-workflow) command also builds the JSON snippets structure plus a variable file definition and variable files per environments to parameterize your JSON snippets and re-use them for multiple properties. We'll use the pipeline files structure in this example. 

Alternatively, the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate the snippets structure plus it will create the basic `*.tf` files and import script. 

## Akamai Property JSON Snippets
An existing property to use as baseline can be imported into snippets by submitting the following snippets command:

`$ akamai snippets import -p <PROPERTY-NAME>`

The resulting JSON snippets will be located under the folder PROPERTY-NAME/config-snippets. You can copy these files under a different folder where the TF configuration will reference to. In this example these have been moved to the Terraform project folder as property-snippets/.

## Terraform Modules
Modules in TF are pieces of code that can be reused by parameterizing them and calling them within our main Terraform code. By practice the modules are created in the `/modules/` folder and they look just like normal HCL.
In the `/modules/` folder there is also a `variables.tf` file which contains all the parameters consumed by the module. All these parameters must be passed when calling the module.

In this example the module is re-used by each one of the environments to deploy/maintain. These can be found under the `/environments/` folder.

## Template Characteristics
* Manage multiple properties. In this example 2 properties named `terraform-dev` and `terraform-prod`.
* In the `modules/property.tf` the `template_file` resource is used to point to the template file and pass the variables to substitute in the template file as well as in the JSON snippets.
    ```
    data "template_file" "rules" {
        template = templatefile("../../property-snippets/main.tfjson", {
            global_templates_path = "../../property-snippets"
            env_specific_templates_path = "../../property-snippets/${var.customer_env}"
            customer_env = var.customer_env
            comments = var.comments
            origin = var.origin
        })

        # Variables for the rest of the JSON snippets
        vars = {
            cpcode = var.cpcode
        }
    }
    ```
    All the variables passed on to the template file and the JSON snippets come from the `variables.tf` file. Note that in both the template file and the JSON snippets the parameter placeholder syntax is like this `"${origin}"`.


* Property version notes are added by the `comments` variable defined in the `variables.tf` file:
    ```
    "comments": {
        "type": "userVariableValue",
        "default": "Activated by Terraform"
    }
    ```
    The variable is referenced in the `property-snippets/main.tfjson` template at the same level as the `rules` key.

    ```
    variable "comments" {
        default = "Added by Terraform"
    }
    ```
* In the `main.tfjson` the JSON snippets are not added by `includes`. Instead the following TF template syntax is used:
    ```
    ${file("${global_templates_path}/Augment_insights.json")},
    ${file("${global_templates_path}/Accelerate_delivery.json")},
    ${file("${global_templates_path}/Offload_origin.json")},
    ${file("${global_templates_path}/Strengthen_security.json")},
    ${file("${global_templates_path}/Increase_availability.json")},
    ${file("${global_templates_path}/Minimize_payload.json")}
    ```
    The `global_templates_path` file comes from the main TF code in the `property.tf` which points to the `property-snippets/` folder.

* In the `main.tfjson` different rules can be loaded per property by using TF template conditional through this syntax:
    ```
    %{ if customer_env == "dev" }
    ,${file("${env_specific_templates_path}/No_Offload_origin.json")}
    %{ endif }
    ```
    In this scenario, only when the property is our `dev` property the `property-snippets/dev/No_Offload_origin.json` is added to the rule tree.


* Tproperty names is controlled by the variable `customer_env`: 
    ```
    resource "akamai_property" "my_property" {
        name        = "terraform-${var.customer_env}"
        product_id  = var.product_id
        contract_id = data.akamai_contract.contract.id
        group_id    = data.akamai_contract.contract.group_id
    ```

* The hostnames are added by the variable `property_and_edge_hostnames` which allows for setting up multiple hostnames with their respective edge hostnames. Here's an example with 2 hostnames and 2 edge hostnames:

    ```
    property_and_edge_hostnames = [{
            property_hostname = "tf-dev.host.com"
            edge_hostname     = "tf-dev.edgesuite.net"
        },
        {
            property_hostname = "tf-prod.host.com"
            edge_hostname     = "tf-prod.edgesuite.net"
        }]
    ```

    A simple way to iterate through these hostnames is by using dynamic blocks inside the `akamai_property` resource:

    ```
    dynamic "hostnames" {
        for_each = var.property_and_edge_hostnames

        content {
            cname_from             = hostnames.value.property_hostname
            cname_to               = hostnames.value.edge_hostname
            cert_provisioning_type = "DEFAULT"
        }
    }
    ```
    The hostnames in this example use the Secure by Default certificate provisioning type.

## Import
The `import.sh` file can be used as a reference on how to import existing resources in Akamai into Terraform state. Note that in this example each resource import must done under the intended environment taking into account the modules syntax.

The documentation for importing the different resources is found in the official Akamai provider documentation:

- [Import a Property](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property)
- [Import an Edge Hostname](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname#import)