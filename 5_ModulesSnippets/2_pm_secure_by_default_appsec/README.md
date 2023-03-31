# Secure by Default Onboard to Akamai

**Use Case:** Fully onboard a domain to Akamai incluiding the certificate creation (Secure by Default), edge hostname, cp code, property, DNS records and application security. Based on [Akamai's Official Examples](https://github.com/akamai/examples-terraform)

## Property Manager Provider
Use for creating new Edge Hostnames, CP Codes and of course new Properties. In this particular case the Edge Hostname creation was created as a separate module for illustration purposes only. Observe that the Edge Hostname creation needs the enrollment ID from the certificate creation.

The property is created from some local JSON snippets files. You can think of this files as your baseline or golden configuration files. 

For information as to how these snippets were obtained you can check the Akamai Property Manager CLI [snippets](https://github.com/akamai/cli-property-manager#property-management-with-snippets-workflow).

The Akamai Property Manager CLI [pipeline](https://github.com/akamai/cli-property-manager#akamai-pipeline-workflow) can also be used to build the JSON snippets structure plus a variable file definition and variable files per environments to parameterize your JSON snippets and re-use them for multiple properties. 

Alternatively, the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate the snippets structure plus it will create the basic `*.tf` files and import script. Therefore if you have a golden configuration already on Akamai you can just use it to build the base for your code.

### The Certificates
A new certificate is automatically created for each hostname with Secure by Default. These are Let's Encrypt Domain Validation certificates which will be ready to validate once the property has been activated (staging or production).

## Edge DNS Provider
With Secure by Default the created certificates are Let's Encrypt Domain Validation which require you to validate the domains. Possibly the quickest and easiest way to do this is by fullfiling the DNS challenges. 
This module will download the DNS chanllenges and create the respective records in EdgeDNS as well as the CNAME record for the new domain which points to the Akamai network. The latter is the entry point to Akamai.

## Application Security Provider
Similarly to Property Manager you can have an existing security configuration that you can export to TF code with the use of the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform).

For this particular example a security configuration was created with a new policy and added the new hostname to it. There are some assets that can be used by different security configurations such as Network Lists, and to reuse these they can be imported to TF.

### Import
The `import.sh` file can be used as a reference on how to import existing resources in Akamai into Terraform state. Note that in this example some resources like network lists and rate policies are imported to be used inside our new security configuration.

This should be the very first step before you run any `terraform plan/apply`.