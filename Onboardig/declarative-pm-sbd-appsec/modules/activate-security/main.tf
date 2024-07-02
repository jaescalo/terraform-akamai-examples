data "akamai_appsec_configuration" "config" {
  name = var.name
}

resource "akamai_appsec_activations" "appsec-activation-staging" {
  config_id           = var.config_id
  network             = "STAGING"
  note                = var.note
  notification_emails = var.notification_emails
  version             = var.activate_appsec_on_staging ? data.akamai_appsec_configuration.config.latest_version : data.akamai_appsec_configuration.config.staging_version
}

resource "akamai_appsec_activations" "appsec-activation-production" {
  config_id           = var.config_id
  network             = "PRODUCTION"
  note                = var.note
  notification_emails = var.notification_emails
  version             = var.activate_appsec_on_production ? data.akamai_appsec_configuration.config.latest_version : data.akamai_appsec_configuration.config.production_version
}
