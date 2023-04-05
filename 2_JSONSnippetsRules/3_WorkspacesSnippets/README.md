# Manage Multiple Properties with JSON Snippets and Workspaces
By using the Akamai Property Manager CLI [snippets](https://github.com/akamai/cli-property-manager#property-management-with-snippets-workflow) command a property can be broken down into several json snippet files (one snippet per parent rule by default), which are easier to manage than a single JSON file containing all the rules.

The Akamai Property Manager CLI [pipeline](https://github.com/akamai/cli-property-manager#akamai-pipeline-workflow) command also builds the JSON snippets structure plus a variable file definition and variable files per environments to parameterize your JSON snippets and re-use them for multiple properties. We'll use the pipeline files structure in this example. 

Alternatively, the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate the snippets structure plus it will create the basic `*.tf` files and import script. 

## Akamai Property JSON Snippets
An existing property to use as baseline can be imported into snippets by submitting the following snippets command:

`$ akamai snippets import -p <PROPERTY-NAME>`

The resulting JSON snippets will be located under the folder PROPERTY-NAME/config-snippets. You can copy these files under a different folder where the TF configuration will reference to. In this example these have been moved to the Terraform project folder as property-snippets/.

## Terraform Workspaces
Workspaces allow to reuse the same snippets/templates and *.tf files, and create different state files based on your environments.
You can think of TF Workspaces as branches in a Git repository, where you could test and work on parallel changes before pushing them to production. 

In the `variables.tf` file a new map type variable is added which is mapped to the TF Workspace name (i.e. dev, prod).
```
variable "customer_env" {
  type = map(any)
  default = {
    default = "prod"
    dev     = "dev"
  }
}
```
By default you always work on the `default` workspace, and for this example we only need to create the additional `dev` workspace. When you create a new workspace it becomes your current workspace. Create as many workspaces as needed and update the `variables.tf` accordingly. For example, with this command the `dev` workspace is created:

` terraform workspace new dev`

Next in our *.tf configuration files we'll refer to this variable map `var.customer_env[terraform.workspace]`. For example, the default workspace is named `default`, so when we call `var.customer_env[terraform.workspace]` we will be referencing prod. 

### Workspaces Command Reference
```
$ terraform workspace new <ws name>         # creates a new workspace 
$ terraform workspace show                  # shows the current workspace
$ terraform workspace list                  # lists all the workspaces
$ terraform workspace select <ws name>      # select a workspace to work on
```

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
    The notation `[terraform.workspace]` provides the current workspace name which matches to the enviroments folder names where the variables.json is stored:

    ```
    data "akamai_property_rules_template" "rules" {
        template_file       = abspath("${path.module}/property-snippets/main.json")
        var_definition_file = abspath("${path.root}/environments/variableDefinitions.json")
        var_values_file     = abspath("${path.root}/environments/${var.customer_env[terraform.workspace]}/variables.json")
    }
    ```
    Note the use of the `var_definition_file` and `var_values_file` arguments to pass the variables and values to the JSON snippets.
* Similarly the property names and hostnames are controlled by the variable `customer_env` and `[terraform.workspace]` name. 
    ```
    resource "akamai_property" "my_property" {
        name        = "terraform-${var.customer_env[terraform.workspace]}"
        product_id  = "prd_SPM"
        contract_id = data.akamai_contract.contract.id
        group_id    = data.akamai_contract.contract.group_id
        hostnames {
            cname_from             = "tf-${var.customer_env[terraform.workspace]}.host.com"
            cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
            cert_provisioning_type = "DEFAULT"
        }
        rule_format = "latest"
        rules       = data.akamai_property_rules_template.rules.json
    }
    ```

### Output for Certificate DNS Challenges
* When using the Secure by Default certificate provisioning type the certificates will be created automatically together with the DNS challenges to validate the domains. You need to set these DNS challenges in your DNS provider for the domain validation to happen. To get the DNS challenges the following ouput is specified in the `outputs.tf` file:
    ```
    output "hostnames" {
        value = akamai_property.my_property.hostnames
    }
    ```

## Import
The `import.sh` file can be used as a reference on how to import existing resources in Akamai into Terraform state. Note that in this example each resource import must done under the intended workspace. By default you always work on the `default` workspace, and for this example we only need to create the additional `dev` workspace. When you create a new workspace it becomes your current workspace.

The documentation for importing the different resources is found in the official Akamai provider documentation:

- [Import a Property](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property)
- [Import an Edge Hostname](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname#import)