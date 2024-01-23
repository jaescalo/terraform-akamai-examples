# Akamai Terraform Templates
These are some example on how the Akamai Terraform provider can be used to onboard and maintain one or more properties. 

*Keyword(s):* terraform, akamai provider, automation, for_each, modules, workspace<br>

## Prerequisites
- [Akamai API Credentials](https://developer.akamai.com/getting-started/edgegrid) for creating propertie, hostnames and CP codes.
- [Akamai TF Provider](https://registry.terraform.io/providers/akamai/akamai/latest/docs). For older versions of the provider some of the fields are no longer supported. See the [change log](https://github.com/akamai/terraform-provider-akamai/blob/master/CHANGELOG.md) for the Akamai provider for more details.
- [Akamai Property Manager CLI](https://github.com/akamai/cli-property-manager)
- The examples assume the CP Codes are available before hand because the intention is to manage existing resources on Akamai. However in an onboarding scenario you'll want to create the new CP Codes in the TF code.

# Property Manager
## 1. Monolithic Rule Tree
This is the simplest case where the rule tree is a single JSON file which contains all the rules, match criteria and behaviors.

### 1. Single Environment
No multi-environment setup. Only one property built based on the parameters defined in the `variables.tf`.

## 2. JSON Snippets

### 1. Single Environment
Breaks down the monolitc rule tree into JSON snippets files which can be managed in an easier way. There are 2 scenarios:

1. #### /1_ak_templates
    Uses the Akamai provider's `akamai_property_rules_template` data source to merge all the JSON snippets into the final rule tree.

2. #### /2_tf_templates
    Uses Hashicorp's `template_file` data source and the `templatefile` together with the JSON snippets and a TF template file that allows for other powerful functions.

### 2. Multiple Environments
Allows for deploying multiple resources by iterating through a list of resources to onboard or modify. This is achieved with the `for_each` meta-argument. There are 2 scenarios:

1. #### TFVARS variables approach
    Relies on passing the parameters to the JSON snippets via the `./environment/*.tfvars` variable files used in the `akamai_property_rules_template` resource.

2. #### TF variables approach
    Relies on passing the parameters to the JSON snippets via the `variables` blocks inside the `akamai_property_rules_template` resource.

3. #### JSON Variables files
    Additionally, when using Akamai JSON Snippets, these can be parameterized through variables defined in a `variableDefinitions.json` file and the values added to each environment in the `environments/{env}/variables.json` files.

### 3. Terraform Workspaces
Workspaces allow to reuse the same snippets/templates and *.tf files, and create different state files based on your environments.
You can think of TF Workspaces as branches in a Git repository, where you could test and work on parallel changes before pushing them to production. 

### 4. Terraform Modules
Makes use of TF Modules which provide more flexibility for code reutilization and environment isolation.
Modules in TF are pieces of code that can be reused by parameterizing them and calling them within our main Terraform code. By practice the modules are created in the `/modules/` folder and they look just like normal HCL.

1. #### Same Rule Tree with Akamai Template
    Manage or onboard multiple properties that share the same rule tree structure onto Akamai by using the Akamai Terraform Provider's `akamai_property_rules_template` resource.

2. #### Different Rule Tree with Akamai Template
    Manage or onboard multiple properties that have a different rule tree structure onto Akamai by using the Akamai Terraform Provifer's `akamai_property_rules_template` resource. One `main.json` file is required per property as each file will contain the rule tree structure.

3. #### Different Rule Tree with Terraform Templates
    Manage or onboard multiple properties that have a different rule trees onto Akamai by using the Terraform `template_file` resource instead of the Akamai Provider's `akamai_property_rules_template` resource. When using the `template_file` resource there's a bit more flexibility when building properties that differ in the rules. Also, the template file syntax will change and we'll call the file `main.tfjson` instead of the traditional `main.json`.

## 3. Declarative Rule Tree
As of Akamai TF Provider version 3.5.0 (March 30th 2023) the property can be fully expressed in HCL (Hashicorp Configuration Language). 

### 1. Single Environment
The rule tree is fully expressed in HCL (Hashicorp Configuration Language)

### 2. Multiple Environments
The rule tree is fully expressed in HCL (Hashicorp Configuration Language) too, plus supports different environments using *.tfvars files. Additionaly there is logic that determines the type of origin (CUSTOMER | NETSTORAGE) to build the correct rule tree. This is one of the benefits of expressing the rule tree as HCL, it is easier to add more logic to the rule tree.

# Onboarding
Examples to fully onboard domains to Akamai with Property Manager, EdgeDNS, Application Security and CPS features.

## 1. Declarative Property Manager
An approach to managing an Akamai Property using the declarative syntax (all property rules, behaviors matches expressed in HCL) plus a structure that uses modules to split the `rules.tf` file into multiple more manageable files. No need to use modules for this though.

## 2. JSON Snippets Property Manager
### 1. Property Secure by Default Onboard to Akamai
    Onboards a domain to Akamai from scratch: creates certificate with Secure by Default, edge hostname, property, dns records and application security configurations.

### 2. Property Full Onboard to Akamai
    Onboards a domain to Akamai from scratch: creates certificate, edge hostname, property, dns records and application security configurations.

# Debugging
For debugging you can enable the logging level: OFF, TRACE, DEBUG, INFO, WARN or ERROR. TRACE will give the Akamai outputs.
 
`$ export TF_LOG=TRACE`

Additionally you can set the path of the log with the `TF_LOG_PATH` variable:

`$ export TF_LOG_PATH=./akamai.log`

# Akamai as Code and Terraform Best Practices
- **Version Control**: treat Akamai as Code as you would with any of your current applications. This entails the version control repository or preference, access policies, security policies, collaboration, branching and merging schemas.

- **Credentials**: the permissions you need for the Akamai Provider depend on the subset of Akamai resources and data sources you'll use (i.e. EdgeDNS, Appsec, Property Manager, etc). Without these permissions, your Terraform configurations won't execute. Additionally API credential permissions can be assigned on a per group or user basis and set to read or read/write mode.

- **Golden Configurations & Code Reutilization**: some use cases suchs as onboardings can benefit from parameterized golden configurations that can be reused to spin up new domains and applications. 

- **Avoid Drift**: your Akamai as Code must be your source of truth for any of the resources managed as code. If a change occurs outside your official code (i.e. UI) this will cause a drif and must be reconciled manually.  

- **Existing Resources**: for resources that already exist on Akamai that you want to reuse always import them to TF. This will sync Terraform's state with the actual resources deployed on Akamai. Use [Akamai's Terraform CLI](https://github.com/akamai/cli-terraform) for ease of importing existing resources. Each sub-provider has its import syntax, here's an example for importing an existing property. 
    ```
    $ terraform import akamai_property.example prp_123,ctr_1-AB123,grp_123,ver_3
    ```

- **Non Destroyable Resources**: there are some assets that can't be destroyed from Terraform. In some cases the operation is not even possible in the UI (i.e. Application Security Configuration), or some other times there is not an API for it (i.e. delete an Edge Hostname). When you destroy these assets from TF these will be removed from the state, however they will exist on Akamai. If you need to re-use them then a TF import is required.

- **Resource Dependencies**: TF is great at inferring dependencies. However, the use of the `depends_on` meta argument is recommended especially if you are working with TF modules. See the [Full Onboard Example](https://github.com/jaescalo/terraform-akamai-use-cases/tree/main/5_ModulesSnippets/3_cps_pm_dns_appsec)

- **Version Lock Down**: lock your Terraform and providers to a specific version to prevent breaking changes on future versions. This applies to any other application and/or templates. Manually migrate to later version when appropriate or required.

    - **Specific to Property-Manager**: assign the most recent dated `rule_format` (i.e. v2023-01-05) in any API driven workflow. Otherwise, if you assign the `latest` rule format to your rule tree, features update automatically to their most recent version. This may abruptly result in errors if JSON objects your rules specify no longer comply with the most recent feature's set of requirements.

- **Terraform State File**: for security and collaboration reasons storing the state file in your version control repository is not a good practice and instead you should use a remote backend. Some remote backends support collaboration, locking, encryption and other features. Always check [Hashicorp's documentation](https://developer.hashicorp.com/terraform/cdktf/concepts/remote-backends) for the list of supported remote backends.

- [Best Practices for Terraform by Google](https://cloud.google.com/docs/terraform/best-practices-for-terraform): great writing on overall TF practices for syntax, collaboration, code optimization and reutilization. 

## More details on Terraform and Akamai Provider
- [Terraform](https://www.terraform.io/)
- [Akamai TF Provider](https://registry.terraform.io/providers/akamai/akamai/latest)
- [Akamai Terraform Examples](https://github.com/akamai/terraform-provider-akamai/tree/master/examples)