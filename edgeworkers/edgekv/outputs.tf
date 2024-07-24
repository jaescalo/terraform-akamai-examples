data "akamai_edgekv_group_items" "contries_group" {
  namespace_name = var.namespace_name
  network        = var.network
  group_name     = var.ekv_group_name_1

}

output "countries" {
  value = data.akamai_edgekv_group_items.contries_group
}

data "akamai_edgekv_group_items" "translations_group" {
  namespace_name = var.namespace_name
  network        = var.network
  group_name     = var.ekv_group_name_2

}

output "languages" {
  value = data.akamai_edgekv_group_items.translations_group
}