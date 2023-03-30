# Manage a Single Property with JSON Snippets

The 2 examples in this repository use different template engines.
* `/ak-template`: uses the Akamai provider's `akamai_property_rules_template` data source to merge all the JSON snippets into the final rule tree. Documentation [HERE](https://registry.terraform.io/providers/akamai/akamai/latest/docs/data-sources/property_rules_template) 

* `/tf-template`: uses Hashicorp's `template_file` data source and the `templatefile` function. Documentation [HERE](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) 

## Main Differences 
### /ak_templates
-  Is the default standard used in some of our other packages such as the [Pipeline CLI](https://github.com/akamai/cli-property-manager#akamai-pipeline-workflow).
-  Allows for use of variable definition and variable value files where to store all the parameters for the JSON snippets. 
- Allows for nested JSON `#include` statements on all the JSON snippets to further store children rules into their own separate JSON snippet files.

### /tf_templates
- Allows for the use of conditinal statements (if/else), iterations, concatenate variables with other values, and many more terraform functions directly on the template file. 
- When working with multiple environments (i.e. dev, qa, prod) which are not fully in sync it allows to create conditionals for which rules to include on a per environment basis.
- Does NOT allow for nested JSON #includes out of the box as there an only be one terraform template. However you could have several `template_file` data source blocks pointing to separate template files.

## Hybrid Model
You could setup a hybrid model utilizing both `akamai_property_rules_template` and `template_file` in the same TF module or code.
A use case is to avoid repetition. For example if you have 50 redirect rules which are the same except of the incoming URL and resulting URL you could write a TF template file that iterates over the data set to build a JSON with the 5 redirects. This resulting JSON file can be used as one of the JSON snippets for the `akamai_property_rules_template` data source.