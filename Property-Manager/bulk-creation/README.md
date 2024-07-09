# Property Creation in Bulk

Terraform can also be used for bulk operations such as onboardings or modifications. This template creates 3 new properties during a single `terraform apply` for properties named after `dev`, `qa`, and `test`. However, these properties can be different apps (e.g. www, login, api, etc), not necessarily different testing environments. 
By using the `for_each` meta-argument all the resources are created during a single `terraform apply` as opposed to other multi-environment setups where each configuration can be deployed independently. The latter is more convenient for day to day operations. 

## Terraform plan/apply
To plan/apply::

`$ terraform plan`
`$ terraform apply`