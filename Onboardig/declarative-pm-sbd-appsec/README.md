# Secure by Default Onboard to Akamai

**Use Case:** Fully onboard a domain to Akamai including the certificate creation (Secure by Default), edge hostname, cp code, property, DNS records and application security. In this particular example 2 hostnames are onboarded which presents an additional challenge to the configuration because of the need of reusing the code to create and validate DNS records.

## Property Manager Provider
Creates new Edge Hostnames, CP Codes and of course new Properties. The property is also expressed fully in HCL (no longer JSON snippet dependencies). This was a featured introduced early in 2023. 
The [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate all of the necessary `*.tf` files and import script. Therefore if you have a golden configuration already on Akamai you can just use it to build the base for your code.

### The Certificates
A new certificate is automatically created for each hostname with Secure by Default. These are Let's Encrypt Domain Validation certificates which will be ready to validate once the property has been activated (staging or production).

## Edge DNS Provider
With Secure by Default the created certificates are Let's Encrypt Domain Validation which require you to validate the domains. Possibly the quickest and easiest way to do this is by fulfilling the DNS challenges. 
This module will download the DNS challenges and create the respective records in EdgeDNS as well as the CNAME records for the new domains which point to the Akamai network. The latter are the entry points to Akamai.

## Application Security Provider
Similarly to Property Manager you can have an existing security configuration that you can export to TF code with the use of the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform).

For this particular example we assume an Application Configuration exists, therefore we import all the required resources by the use of the `appsec-import.sh` script.