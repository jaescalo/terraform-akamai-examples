# Domain Full Onboard to Akamai

**Use Case:** Fully onboard a domain to Akamai incluiding the certificate creation, edge hostname, cp code, property, DNS records and application security.

All of the required parameters for this flow should be added/replaced in the `terraform.tfvars` file, unless of course you want to modify the flow then you can edit any of the other `*.tf` files.

## Certificate Provisioning System Provider
This example is for a Third Party certificate which requires an extra step to download the CSR to have the CA sign the certificate which is then uploaded to Akamai.
The `certificate` module is based on this [EXAMPLE](https://registry.terraform.io/providers/akamai/akamai/latest/docs/resources/cps_third_party_enrollment) in the provider's documentation.

As with any Akamai third party certificate once the CSR is downloaded it must be provided to the Certificate Authority to sign/create the certificate. This certificate is then uploaded to Akamai CPS.
For illustration purposes ONLY this step is simulated by locally signing the certificate with a self signed root cert. But in a fully automated real world use case it should be integrated with your Certificate Authority.

## Property Manager Provider
Use for creating new Edge Hostnames, CP Codes and of course new Properties. In this particular case the Edge Hostname creation was created as a separate module for illustration purposes only. Observe that the Edge Hostname creation needs the enrollment ID from the certificate creation.

The property is created from some local JSON snippets files. You can think of this files as your baseline or golden configuration files. 

For information as to how these snippets were obtained you can check the Akamai Property Manager CLI [snippets](https://github.com/akamai/cli-property-manager#property-management-with-snippets-workflow).

The Akamai Property Manager CLI [pipeline](https://github.com/akamai/cli-property-manager#akamai-pipeline-workflow) can also be used to build the JSON snippets structure plus a variable file definition and variable files per environments to parameterize your JSON snippets and re-use them for multiple properties. 

Alternatively, the [Akamai Terraform CLI](https://github.com/akamai/cli-terraform) can also generate the snippets structure plus it will create the basic `*.tf` files and import script. Therefore if you have a golden configuration already on Akamai you can just use it to build the base for your code.

## Edge DNS Provider
This example uses Akamai Edge DNS as the DNS provider to create the necessary CNAME record to point the new domain to an Akamai Edge Hostname (*.edgekey.net) on the PCI compliant secure network.

### Import
The `import.sh` file can be used as a reference on how to import existing resources in Akamai into Terraform state. Note that in this example only the Application Security Configuration is imported as you will commonly have one configuration where you will add all the domains to. This configuration can have multiple policies though.

Because the security configuration exists on Akamai we need to import it to Terraform and this is done with the `terraform import` command. Check the `import.sh` file for an example. This should be the very first step before you run any `terraform plan/apply`.