locals {
  items_countries = {
    # Key must only use a string that matches A-Z a-z 0-9 _ or -..
    "Spain"        = "{\"key\":\"Spain\",\"code\":\"ESP\",\"language\":\"sp\",\"isd\":\"34\"}"
    "France"       = "{\"key\":\"France\",\"code\":\"FRA\",\"language\":\"fr\",\"isd\":\"33\"}"
    "Germany"      = "{\"key\":\"Germnay\",\"code\":\"DEU\",\"language\":\"de\",\"isd\":\"49\"}"
    "Italy"        = "{\"key\":\"Italy\",\"code\":\"ITA\",\"language\":\"it\",\"isd\":\"39\"}"
    "South-Africa" = "{\"key\":\"South Africa\",\"code\":\"ZAF\",\"language\":\"en\",\"isd\":\"27\"}"
  }

  items_translations = {
    "es" = "HOLA MUNDO"
    "fr" = "BONJOUR LE MONDE"
    "de" = "HALLO WELT"
    "it" = "CIAO MONDO"
    "zu" = "SAWUBONA MHLABA"
    "pt" = "OLÁ MUNDO"
  }
}


data "akamai_contract" "contract" {
  group_name = var.group_name
}

# Create new namespace
resource "akamai_edgekv" "edgekv" {
  namespace_name       = var.namespace_name
  network              = var.network
  group_id             = parseint(replace(data.akamai_contract.contract.group_id, "grp_", ""), 10) # Akamai Access Group ID
  retention_in_seconds = 0
  geo_location         = var.geo_location
}

# Create a new group within the namespace and add items
resource "akamai_edgekv_group_items" "contries_group" {
  namespace_name = akamai_edgekv.edgekv.namespace_name
  network        = var.network
  group_name     = var.ekv_group_name_1 # Group name within the namespace. Not to be confused with the Akamai Access Group
  items = local.items_countries
}

# Create a new group within the namespace and add items
resource "akamai_edgekv_group_items" "translations_group" {
  namespace_name = var.namespace_name
  network        = var.network
  group_name     = var.ekv_group_name_2 # Group name within the namespace. Not to be confused with the Akamai Access Group
  items = local.items_translations
}
