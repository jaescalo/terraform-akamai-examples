
terraform init
# DEV
terraform import -var-file=./environments/dev.tfvars akamai_cp_code.cp_code cpc_1662022,ctr_1-1NC95D,grp_257477
terraform import -var-file=./environments/dev.tfvars akamai_edge_hostname.my_edge_hostname ehn_5656596,ctr_1-1NC95D,grp_257477
terraform import -var-file=./environments/dev.tfvars akamai_property.my_property prp_1073904,ctr_1-1NC95D,grp_257477
# QA
terraform import -var-file=./environments/qa.tfvars akamai_cp_code.cp_code cpc_1662022,ctr_1-1NC95D,grp_257477
terraform import -var-file=./environments/qa.tfvars akamai_edge_hostname.my_edge_hostname ehn_5656596,ctr_1-1NC95D,grp_257477
terraform import -var-file=./environments/qa.tfvars akamai_property.my_property prp_1073917,ctr_1-1NC95D,grp_257477
# TEST
terraform import -var-file=./environments/test.tfvars akamai_cp_code.cp_code cpc_1662022,ctr_1-1NC95D,grp_257477
terraform import -var-file=./environments/test.tfvars akamai_edge_hostname.my_edge_hostname ehn_5656596,ctr_1-1NC95D,grp_257477
terraform import -var-file=./environments/test.tfvars akamai_property.my_property prp_1074536,ctr_1-1NC95D,grp_257477