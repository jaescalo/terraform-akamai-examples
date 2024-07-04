# Property Creation in Bulk

Terraform can also be used for bulk operations such as onboardings or modifications. This template creates 3 new properties during a single `terraform apply` for properties named after `dev`, `qa`, and `test`. However, these properties can be different apps (e.g. www, login, api, etc), not necessarily different testing environments. 
By using the `for_each` meta-argument all the resources are created during a single `terraform apply` as opposed to other multi-environment setups where each configuration can be deployed independently. The latter is more convenient for day to day operations. 

## Terraform State File Management
This demo assumes a remote backend is configured. Because all the resources are created during a single `terraform apply` a single state file will be used for all the resources. This may not be convenient if the purpose is isolation.


For this template Linode's S3 compatible Object Storage is used as the remote backed. The backend is initialized via a `backend` configuration file which will contain the parameters and keys to connect to the object storage bucket. For example:

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
terraform init -backend-config=backend
```

## Import Existing Property
Often times you want to manage an existing resource on Akamai via Terraform. For this to be successful the initial Terraform state must be created. This can be done by executing the `import-property.sh` script which runs the necessary `terraform import` commands for all the resources exported by the Akamai Terraform CLI.

## Terraform plan/apply
To plan/apply::

`$ terraform plan`
`$ terraform apply`

## Resources
- [Akamai API Credentials](https://techdocs.akamai.com/developer/docs/set-up-authentication-credentials)
- [Akamai Terraform Provider](https://techdocs.akamai.com/terraform/docs)
- [Akamai CLI for Terraform](https://github.com/akamai/cli-terraform)
- [Linode Object Storage](https://www.linode.com/lp/object-storage/)
- [Akamai Developer Youtube Channel](https://www.youtube.com/c/AkamaiDeveloper)
- [GitHub Actions Template Repository](https://github.com/jaescalo/akamai-pm-tf-multiple-env-workflow)
- [Akamai Github](https://github.com/akamai)