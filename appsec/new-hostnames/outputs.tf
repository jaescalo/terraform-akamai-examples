output "contract_id" {
  value = data.akamai_contract.contract.id
}

output "appsec_hostnames" {
  value = data.akamai_appsec_configuration.config.host_names
}