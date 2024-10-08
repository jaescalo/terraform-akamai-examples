# Add New Hostnames to Existing APPSEC Configuration

**Use Case:** Add new hostnames to an existing Akamai Application Security configuration (a.k.a WAF). The common use is to onboard hostnames with the minimum security controls in a quick manner for later fine tunning. 

## Existing AppSec Configuration
The assumption is an AppSec configuration exists and more hostnames must be added to the list of protected hostnames. For this reason the `import.sh` file is provided as an example as to how the existing AppSec configuration can be imported to TF.
The script can be executed as:
```
$ sh import.sh
```
* Note that only the akamai_appsec_configuration is imported. None of the other policies or controls will be modified by the code in this repository. 
* Once the `import.sh` runs the `terraform.tfstate` state file is created. 

## Adding New Hostnames
To introduce new hostnames to the AppSec configuration update the `new_hostnames` value in the `terraform.auto.tfvars` with the new hostnames (e.g. `[ "dev.tf-demo.com", "qa.tf-demo.com" ]` )
