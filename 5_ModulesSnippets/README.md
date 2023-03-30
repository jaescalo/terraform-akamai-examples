# Terraform Modules and JSON Snippets (3 Templating Options)

TF Modules provide the next step of flexibility and code reutilization by executing all the modules or individual modules within different places. Generating different **state files** which can then be stored individually as well. 

There are 3 module examples in this repository:

## 1 - Property Manager
A single module for Property Manager onboarding and maintenance. Three use cases covered:

1. Multiple Properties Using JSON Snippets and TF Modules
2. Multiple Properties with Different Rule Sets Using JSON Snippets and TF Modules
3. Multiple Properties with Different Rule Sets Using JSON Snippets and TF Modules

## 2 - Property Onboard with Secure by Default Hostnames
Onboard a [Secure by Default Property](https://techdocs.akamai.com/property-mgr/reference/onboard-a-secure-by-default-property) to Akamai which uses an automatically generated certificate. This example runs 3 modules that will do the folowing:

1. Property Creation
2. DNS Records update to validate the Domains
3. Add the hostname to a Security Configuration

## 3 - Domain Full Onboard
An approach to onboard a new domain to Akamai which goes through all fo the following:

1. Certificate creation (third party)
2. Edge Hostnames creation
3. Property creation
4. Akamai DNS Records creation
5. Add the new domain to the Security Configuration