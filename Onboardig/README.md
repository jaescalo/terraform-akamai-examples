# Terraform Modules with Akamai Examples

## Secure by Default Onboard to Akamai
Onboard a [Secure by Default Property](https://techdocs.akamai.com/property-mgr/reference/onboard-a-secure-by-default-property) to Akamai which uses an automatically generated certificate. This example runs 3 modules that will do the following:

1. Property Creation using Declarative syntax (HCL)
2. DNS Records update to validate the Domains
3. Add the hostname to a Security Configuration

## Domain Onboard to Akamai
An approach to onboard a new domain to Akamai which goes through all fo the following:

1. Certificate creation (third party)
2. Edge Hostnames creation
3. Property creation
4. Akamai DNS Records creation