resource "akamai_dns_record" "tf_demo_dns_records" {

  for_each = { for entry in akamai_cps_dv_enrollment.enrollment.dns_challenges : entry.domain => entry }

  zone       = "jaescalo.online"
  recordtype = "TXT"
  ttl        = "60"
  target     = [each.value.response_body]
  name       = each.value.full_path
}

resource "time_sleep" "wait_for_dns_records" {
  create_duration = "300s"
  depends_on      = [akamai_dns_record.tf_demo_dns_records]
}
