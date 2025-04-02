## State File Management: Remote Backend
The state file may be renamed differently based on the environment or application to deploy (e.g. `dev-terraform.tfstate`, `qa-terraform.tfstate`) to prevent overwriting the state file for each environment or application.

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