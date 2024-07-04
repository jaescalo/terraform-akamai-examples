
terraform init
terraform import -var-file=./environments/test.tfvars akamai_cp_code.cp_code cpc_1662022,ctr_1-1NC95D,grp_257477
terraform import -var-file=./environments/test.tfvars akamai_edge_hostname.my_edge_hostname ehn_5656596,ctr_1-1NC95D,grp_257477