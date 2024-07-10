output "all_fields" {
  value = data.akamai_datastream_dataset_fields.all_fields
}

output "my_property_ids" {
  value = data.akamai_property.properties[*].id
}

output "datastream_info" {
  value = akamai_datastream.my_datastream
  sensitive = true
}

output "my_datastreams" {
  value = data.akamai_datastreams.my_datastreams
}

output "datastream_id" {
  value = local.datastream_id
}