# Property Manager Multiple Environments - Alternate Rule Trees

The purpose of this template is to ease the process of managing multiple environment properties (e.g. dev, qa, stage, prod) which require different rule trees in Terraform by leveraging the [Akamai Terraform Provider](https://techdocs.akamai.com/terraform/docs).

## Terraform plan/apply
To plan/apply a specific environment:

`$ terraform plan -var-file=./environments/dev.tfvars`