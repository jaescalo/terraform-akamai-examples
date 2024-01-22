# Terraform Modules with Akamai Examples

TF Modules provide the next step of flexibility and code reutilization by executing all the modules or individual modules within different places. Generating different **state files** which can then be stored individually as well. 

There are 3 module examples in this repository:

## 1 - Declarative Property Onboard with Secure by Default Hostnames
Onboard a [Secure by Default Property](https://techdocs.akamai.com/property-mgr/reference/onboard-a-secure-by-default-property) to Akamai which uses an automatically generated certificate. This example runs 3 modules that will do the folowing:

1. Property Creation using Declarative syntax (HCL)
2. DNS Records update to validate the Domains
3. Add the hostname to a Security Configuration

## 2 - JSON Property Onboard with Secure by Default Hostnames
Onboard a [Secure by Default Property](https://techdocs.akamai.com/property-mgr/reference/onboard-a-secure-by-default-property) to Akamai which uses an automatically generated certificate. This example runs 3 modules that will do the folowing:

1. Property Creation using JSON Snippets
2. DNS Records update to validate the Domains
3. Add the hostname to a Security Configuration

## 3 - Domain Full Onboard with CPS
An approach to onboard a new domain to Akamai which goes through all fo the following:

1. Certificate creation (third party)
2. Edge Hostnames creation
3. Property creation
4. Akamai DNS Records creation
5. Add the new domain to the Security Configuration