terraform init
terraform import akamai_edge_hostname.my_edge_hostname ehn_0000000,ctr_0-XXXXXX,grp_00000
terraform import 'akamai_property.my_property["prod"]' prp_00000,ctr_0-XXXXXX,grp_00000
terraform import 'akamai_property.my_property["dev"]' prp_00000,ctr_0-XXXXXX,grp_00000
terraform fmt