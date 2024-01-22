# variable group_name reflects the name of your group you want to store your config. Groups are part of an Akamai contract.
variable "group_name" {}

# variable hostname reflects the hostname you wish to have Akamai deliver and protect.
variable "hostnames" {}

# variable configuration_name reflects the name of your Akamai Application Security configuration. 
variable "name" {}

# variable configuration_description reflects a description for your Akamai Application Security configuration.
variable "description" {}

# variable policy_name reflects the name of your Security Policy that is part of you Akamai Application Security configuration.
variable "security_policy_name" {}

# variable policy_prefix reflects a four digit alphanummerical prefix for your Security Policy.
variable "security_policy_prefix" {}