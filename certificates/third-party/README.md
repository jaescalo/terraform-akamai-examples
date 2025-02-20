# 3rd Party Certificates
Create a new 3rd Party Certificate enrollment in CPS (Certificate Provisioning System). Uses the [ACME Certificate and Account Provider](https://registry.terraform.io/providers/vancluever/acme/latest/docs) to sign the certificate with Let's Encrypt and upload the DNS challenges to Akamai EdgeDNS. 

Credit to [IanCassTwo](https://github.com/IanCassTwo) who came up with the ACME integration with the Akamai CPS resources.

## References
* [Create DV Certificates](https://techdocs.akamai.com/cps/docs/create-a-third-party-certificate)
* [Terraform CPS Provider](https://techdocs.akamai.com/terraform/docs/cps-integration-guide)
* [ACME Certificate and Account Provider](https://registry.terraform.io/providers/vancluever/acme/latest/docs)