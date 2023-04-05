# Manage a Single Property with a Monolithic Rule Tree
This is the simplest case where the rule tree is a single JSON file which contains all the rules, match criteria and behaviors.

## Template Characteristics
* Manage a single property named `tf-demo-property`.
* Rules in a single JSON rule tree file. The rule tree read in TF with this data block
    ```
    data "local_file" "rules" {
        filename = "${path.module}/terraform-demo.v1.rule-tree.json"
    }
    ```
* Two hostnames set up for the property which use the same edge hostname and the Secure by Default feature. With Secure by Default DNS Challenges for the domain validations are generated. These can be outputs in Terraform. See the next use case for an example on how to output the challenges.
    ```
    hostnames {
        cname_from             = "tf-demo.host1.com"
        cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
        cert_provisioning_type = "DEFAULT"
    }
    hostnames {
        cname_from             = "tf-demo.host2.com"
        cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
        cert_provisioning_type = "DEFAULT"
    }
    ```
* The product ID for Ion is `prd_SPM`.  
* Be sure to update the CP code in the rule tree with your own:
    ```
    "behaviors": [
        {
            "name": "cpCode",
            "options": {
                "value": {
                    "cpCodeLimits": null,
                    "createdDate": 1442260495000,
                    "description": "ION CP Code",
                    "id": 0000000,
                    "name": "ION CP Code",
                    "products": [
                        "Fresca",
                        "Site_Accel"
                    ]
                }
            }
        }
    ]
    ```

## Import
The `import.sh` file can be used as a reference on how to import existing resources in Akamai into Terraform state. The documentation for importing the different resources is found in the official Akamai provider documentation:

- [Import a Property](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/property)
- [Import an Edge Hostname](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/edge_hostname#import)