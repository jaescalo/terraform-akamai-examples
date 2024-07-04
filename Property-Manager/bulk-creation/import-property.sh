
terraform init
terraform import 'akamai_cp_code.cp_code["dev"]' cpc_1662022,ctr_1-1NC95D,grp_257477
terraform import 'akamai_cp_code.cp_code["qa"]' cpc_1662022,ctr_1-1NC95D,grp_257477
terraform import 'akamai_cp_code.cp_code["test"]' cpc_1662022,ctr_1-1NC95D,grp_257477
terraform import 'akamai_edge_hostname.my_edge_hostname["dev"]' ehn_5656596,ctr_1-1NC95D,grp_257477
terraform import 'akamai_edge_hostname.my_edge_hostname["qa"]' ehn_5656596,ctr_1-1NC95D,grp_257477
terraform import 'akamai_edge_hostname.my_edge_hostname["test"]' ehn_5656596,ctr_1-1NC95D,grp_257477
terraform import 'akamai_property.my_property["dev"]' prp_1073904,ctr_1-1NC95D,grp_257477
terraform import 'akamai_property.my_property["qa"]' prp_1073904,ctr_1-1NC95D,grp_257477
terraform import 'akamai_property.my_property["test"]' prp_1073904,ctr_1-1NC95D,grp_257477