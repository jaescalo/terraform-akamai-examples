# Multiple Properties with Different Rule Sets Using JSON Snippets and TF Modules

**Use Case:** Manage or onboard multiple properties that have a different rule tree structure onto Akamai by using the Akamai Terraform Provider's `akamai_property_rules_template` resource. One `main.json` file is required per property as each file will contain the rule tree structure.

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
            },
            "comments": {
                "type": "userVariableValue",
                "default": "Activated by Terraform"
            }
        }
    }
    ```
    Default values can be entered in this file, or leave them empty to specify them on a per environment basis.
* Inside the `environments` folder is where each property or environment is defined. For example in the `dev` folder there's the `variables.json` which has the actual parameters for the dev environment.
    ```
    {
        "origin": "origin.dev.host.com",
        "cpcode": 000000,
        "comments": "Managed by Terraform"
    }
    ```
* Property version notes are added by the `comments` variable defined in the `variablesDefinitions.json` file:
    ```
    "comments": {
        "type": "userVariableValue",
        "default": "Activated by Terraform"
    }
    ```
    The variable is referenced in the `property-snippets/main.json` snippet at the same level as the `rules` key in the JSON.

    ```
    {
        "comments": "${env.comments}",
        "rules": {
            ...
    ```
* In your main *.tf file use the data source ["akamai_property_rules_template"](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_template) (introduced in Akamai provider v1.0.0 - Dec9 2020) which lets you configure a rule tree through the use of JSON template files (snippets). You can also keep your Property Manager CLI variable definition files and references (`"${env.<variableName>}"`)

    This is an example use case where the `"${env.cpcode}"` and `"${env.origin}"` are replaced in your JSON snippets by the values defined below and the final rule tree is built.

    ```
    data "akamai_property_rules_template" "rules" {
        template_file       = abspath("${path.module}/property-snippets/main-${var.customer_env}.json")
        var_definition_file = abspath("${path.root}/environments/variableDefinitions.json")
        var_values_file     = abspath("${path.root}/environments/${var.customer_env}/variables.json")
    }
    ```
    Note the use of the `var_definition_file` and `var_values_file` arguments to pass the variables and values to the JSON snippets. Also note the use of the `cusotmer_env` variable in the `template_file` argument when defining the `main.json` file to use. Different `main.json` files can be added with different sets of includes for the other JSON snippets files which will allow to have different rulesets between environments.
    For this example there are 2 `main.json` files created with have includes to different sets of JSON snippets: `main-dev.json` and `main-prod.json`.
    
    Observe that for the `var_values_file` argument we also use the `customer_env` variable which instructs which `variables.json` file to use.
* Similarly the property names is controlled by the variable `customer_env`: 
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