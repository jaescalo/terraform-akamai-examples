terraform init
terraform import akamai_edge_hostname.my_edge_hostname ehn_0000000,ctr_0-XXXXXX,grp_00000
terraform import 'akamai_property.my_property' prp_00000,ctr_0-XXXXXX,grp_00000
terraform workspace new dev
terraform import akamai_edge_hostname.my_edge_hostname ehn_1111111,ctr_0-XXXXXX,grp_00000
terraform import 'akamai_property.my_property' prp_11111,ctr_0-XXXXXX,grp_00000
terraform fmt