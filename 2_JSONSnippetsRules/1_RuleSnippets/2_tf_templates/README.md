# Manage a Single Property with JSON Snippets and TF `templatefile`
By using the Akamai Property Manager CLI [snippets](https://github.com/akamai/cli-property-manager#property-management-with-snippets-workflow) command a property can be broken down into several json snippet files (one snippet per parent rule by default), which are easier to manage than a single JSON file containing all the rules.
Alternatively, the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate the snippets structure plus it will create the basic `*.tf` files and import script. 

Once the JSON snippets are generated it is easier to introduce the Terraform templating language to reutilize the JSON snippets.

## Akamai Property JSON Snippets
An existing property to use as baseline can be imported into snippets by submitting the following snippets command:

`$ akamai snippets import -p <PROPERTY-NAME>`

The resulting JSON snippets will be located under the folder PROPERTY-NAME/config-snippets. You can copy these files under a different folder where the TF configuration will reference to. In this example these have been moved to the Terraform project folder as property-snippets/.

## Template Characteristics
* Manage a single property named `tf-demo-property`.
* Variables defined in the `variables.tf` file and their values set in the `terraform.tfvars` file.
* In your main *.tf file use the data source ["template_file"](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) which lets you configure a template with Terraform functions to build the final rule tree based on the JSON snippets. We can take the `main.json` and convert it to the Terraform template file and rename to `main.tfjson`.

    This are some examples of what can be done with the TF `template_file` in combination with the `templatefile` function. 
    
    1. All the variables in the `main.tfjson` can be expressed as (note the double quotes):
    ```
    "${variable_name}"
    ```
    All of the variables on the rest of the JSON snippets can be expressed as (do not use double quotes):
    ```
    ${variable_name}
    ```
    2. If you have an array of values (i.e. origin_default_cn_list = ["host1.com", "host2.com", "host3.com"])and you need to build certain expression such as the certificate common name match list:
    ```
    "customValidCnValues": ${jsonencode(
        [for origin_cn in origin_default_cn_list : "${origin_cn}"
        ],
        )},
    ```
    3. Include the rest of the JSON snippets using the file function. As you can see you can add varibles in the path to the file in case you have variants of the JSON snippets.
    ```
    "children": [
      ${file("${global_templates_path}/Augment_insights.json")
      },
      ${file("${global_templates_path}/Accelerate_delivery.json")
      },
      ${file("${global_templates_path}/Offload_origin.json")
      },
      ${file("${global_templates_path}/Strengthen_security.json")
      },
      ${file("${global_templates_path}/Increase_availability.json")
      },
      ${file("${global_templates_path}/Minimize_payload.json")
      }
    ],
    ```
    And from the TF code side in the `main.tf`:
    ```
    data "template_file" "rules" {
    template = templatefile("./property-snippets/main.tfjson", {
        global_templates_path = "./property-snippets"
        comments = var.comments
        origin = var.origin
        origin_default_cn_list = var.origin_default_cn_list
    })

    # Variables for the rest of the JSON snippets (*.json file)
    vars = {
        cpcode = parseint(replace(akamai_cp_code.cp_code.id, "cpc_", ""), 10)
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
    The variable is referenced in the `property-snippets/main.tfjson` snippet at the same level as the `rules` key in the JSON.

    ```
    {
        "comments": "${comments}",
        "rules": {
            ...
    ```
    Observe there's a two-stage template evaluation because TF doesnt not allow recursive calls to `templatefile`:
    1. Assemble the snippets using templatefile()
    2. Interpolate the variables into the resulting template

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