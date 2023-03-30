# Manage a Single Property with JSON Snippets
By using the Akamai Property Manager CLI [snippets](https://github.com/akamai/cli-property-manager#property-management-with-snippets-workflow) command a property can be broken down into several json snippet files (one snippet per parent rule by default), which are easier to manage than a single JSON file containing all the rules.
Alternatively, the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate the snippets structure plus it will create the basic `*.tf` files and import script. 

## Akamai Property JSON Snippets
An existing property to use as baseline can be imported into snippets by submitting the following snippets command:

`$ akamai snippets import -p <PROPERTY-NAME>`

The resulting JSON snippets will be located under the folder PROPERTY-NAME/config-snippets. You can copy these files under a different folder where the TF configuration will reference to. In this example these have been moved to the Terraform project folder as property-snippets/.

## Template Characteristics
* Manage a single property named `tf-demo-property`.
* Variables defined in the `variables.tf` file and their values set in the `terraform.tfvars` file.
* In your main *.tf file use the data source ["akamai_property_rules_template"](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_template) (introduced in Akamai provider v1.0.0 - Dec9 2020) which lets you configure a rule tree through the use of JSON template files (snippets). You can also keep your Property Manager CLI variable definition files and references (`"${env.<variableName>}"`)

    This is an example use case where the `"${env.cpcode}"`, `"${env.origin}"` and `"${env.comments}"` are replaced in your JSON snippets by the values defined below and the final rule tree is built:

    ```
    data "akamai_property_rules_template" "rules" {
        template_file = abspath("${path.module}/property-snippets/main.json")
        variables {
            name  = "cpcode"
            value = parseint(replace(akamai_cp_code.cp_code.id, "cpc_", ""), 10)
            type  = "number"
        }
        variables {
            name  = "origin"
            value = var.origin
            type  = "string"
        }
            variables {
            name  = "comments"
            value = var.comments
            type  = "string"
        }
    }
    ```
* Property version notes are added by the TF `comments` variable defined in the `variables.tf` file:
    ```
    variable "comments" {
    type        = string
    description = "Property Version Notes"
    }
    ```
    The variable is referenced in the `property-snippets/main.json` snippet at the same level as the `rules` key in the JSON.

    ```
    {
        "comments": "${env.comments}",
        "rules": {
            ...
    ```

* The hostnames are added by the variable `property_and_edge_hostnames` which allows for setting up multiple hostnames with their respective edge hostnames. Here's an example with 2 hostnames and 2 edge hostnames:

    ```
    property_and_edge_hostnames = [{
        property_hostname = "tf-demo.host1.com"
        edge_hostname     = "tf-demo1.edgesuite.net"
        },
        {
            property_hostname = "tf-demo.host2.com"
            edge_hostname     = "tf-demo2.edgesuite.net"
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

### Output for Certificate DNS Challenges
* When using the Secure by Default certificate provisioning type the certificates will be created automatically together with the DNS challenges to validate the domains. You need to set these DNS challenges in your DNS provider for the domain validation to happen. To get the DNS challenges the following ouput is specified in the `outputs.tf` file:
    ```
    output "hostname_challenges" {
        value = [for target in akamai_property.my_property.hostnames : target.cert_status[*]]
    }
    ```

## Import
The `import.sh` file can be used as a reference on how to import existing resources in Akamai into Terraform state. The documentation for importing the different resources is found in the official Akamai provider documentation:

- [Import a Property](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property)
- [Import an Edge Hostname](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname#import)