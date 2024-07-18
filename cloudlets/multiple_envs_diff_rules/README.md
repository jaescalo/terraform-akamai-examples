# Edge Redirector Cloudlet for Multiple Environments - Alternate Match Rules

The purpose of this template is to ease the process of managing multiple environment cloudlet policies (e.g. dev, qa, stage, prod) which require different match rules in Terraform by leveraging the [Akamai Terraform Provider](https://techdocs.akamai.com/terraform/docs).

## Terraform plan/apply
To plan/apply a specific environment:

`$ terraform plan -var-file=./environments/dev.tfvars`