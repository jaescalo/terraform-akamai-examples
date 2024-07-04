# Property Manager Multiple Environments

The purpose of this template is to ease the process of managing multiple environment properties (e.g. dev, qa, stage, prod) in Terraform by leveraging the [Akamai Terraform Provider](https://techdocs.akamai.com/terraform/docs).

## Terraform State File Management
This demo assumes a remote backend is configured and that the state file is named after each environment (e.g. `dev-terraform.tfstate`, `qa-terraform.tfstate`) to prevent overwriting the state file for each environment.

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
terraform init -backend-config=backend -reconfigure
```

The `-reconfigure` flag can be used when switching environments as the state file should be renamed after the environment. In a CI/CD this step can be parameterized and automated. 

## Import Existing Property
Often times you want to manage an existing resource on Akamai via Terraform. For this to be successful the initial Terraform state must be created. This can be done by executing the `import.sh` script which runs the necessary `terraform import` commands for all the resources exported by the Akamai Terraform CLI.

## Terraform plan/apply
To plan/apply a specific environment:

`$ terraform plan -var-file=./environments/dev.tfvars`

## Resources
- [Akamai API Credentials](https://techdocs.akamai.com/developer/docs/set-up-authentication-credentials)
- [Akamai Terraform Provider](https://techdocs.akamai.com/terraform/docs)
- [Akamai CLI for Terraform](https://github.com/akamai/cli-terraform)
- [Linode Object Storage](https://www.linode.com/lp/object-storage/)
- [Akamai Developer Youtube Channel](https://www.youtube.com/c/AkamaiDeveloper)
- [GitHub Actions Template Repository](https://github.com/jaescalo/akamai-pm-tf-multiple-env-workflow)
- [Akamai Github](https://github.com/akamai)