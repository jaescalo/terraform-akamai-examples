# Akamai Terraform Examples
These are some example on how the Akamai Terraform provider can be used to onboard and maintain resources on Akamai.

*Keyword(s):* terraform, akamai provider, automation, for_each, modules<br>

## Prerequisites
- [Akamai API Credentials](https://developer.akamai.com/getting-started/edgegrid) for creating properties, hostnames and CP codes.
- [Akamai TF Provider](https://registry.terraform.io/providers/akamai/akamai/latest/docs). For older versions of the provider some of the fields are no longer supported. See the [change log](https://github.com/akamai/terraform-provider-akamai/blob/master/CHANGELOG.md) for the Akamai provider for more details.
- [Akamai Property Manager CLI](https://github.com/akamai/cli-property-manager)
- The examples assume the CP Codes are available before hand because the intention is to manage existing resources on Akamai. However in an onboarding scenario you'll want to create the new CP Codes in the TF code.


## State File Management
Most of these examples assume a remote backend is configured for storing the state file. The state file may be renamed differently based on the environment or application to deploy (e.g. `dev-terraform.tfstate`, `qa-terraform.tfstate`) to prevent overwriting the state file for each environment or application.

Linode's S3 compatible Object Storage is used as the remote backend for these examples. The backend is initialized via a `backend` configuration file which will contain the parameters and keys to connect to the object storage bucket. For example:

```
skip_credentials_validation=true
skip_region_validation=true
skip_requesting_account_id=true
bucket="my-bucket"
key="property-manager/multiple-environments/qa-terraform.tfstate"
region="us-mia-1"
endpoints={ s3 = "https://us-mia-1.linodeobjects.com" }
access_key="ACC3S5K3Y"
secret_key="S3CRE7KEY"
```

The backend configuration then is initialized during the `terraform init` command:

```
terraform init -backend-config=backend -reconfigure
```

The `-reconfigure` flag can be used when switching environments as the state file should be renamed after the environment. In a CI/CD this step can be parameterized and automated. 

## Import Existing Resources into TF
The `import-*.sh` files can be used as a reference to import existing resources in Akamai into Terraform state. 
This should be the very first step before you run any `terraform plan/apply`.

## Debugging
For debugging you can enable the logging level: OFF, TRACE, DEBUG, INFO, WARN or ERROR. TRACE will give the Akamai outputs.
 
`$ export TF_LOG=TRACE`

Additionally you can set the path of the log with the `TF_LOG_PATH` variable:

`$ export TF_LOG_PATH=./akamai.log`

## Akamai as Code and Terraform Best Practices
- **Version Control**: treat Akamai as Code as you would with any of your current applications. This entails the version control repository or preference, access policies, security policies, collaboration, branching and merging schemas.

- **Credentials**: the permissions you need for the Akamai Provider depend on the subset of Akamai resources and data sources you'll use (i.e. EdgeDNS, Appsec, Property Manager, etc). Without these permissions, your Terraform configurations won't execute. Additionally API credential permissions can be assigned on a per group or user basis and set to read or read/write mode.

- **Golden Configurations & Code Reutilization**: some use cases such as onboardings can benefit from parameterized golden configurations that can be reused to spin up new domains and applications. 

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

## Resources
- [Akamai API Credentials](https://techdocs.akamai.com/developer/docs/set-up-authentication-credentials)
- [Akamai Terraform Provider](https://techdocs.akamai.com/terraform/docs)
- [Akamai CLI for Terraform](https://github.com/akamai/cli-terraform)
- [Linode Object Storage](https://www.linode.com/lp/object-storage/)
- [Akamai Developer Youtube Channel](https://www.youtube.com/c/AkamaiDeveloper)
- [GitHub Actions Template Repository](https://github.com/jaescalo/akamai-pm-tf-multiple-env-workflow)
- [Akamai Github](https://github.com/akamai)