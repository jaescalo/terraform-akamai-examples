# Common Variables
environment     = "dev"
group_name      = "Demos - Templates"
config_name     = "tf-demo-appsec"
description     = "Application security configuration - DO NOT DELETE"
hostnames       = ["dev.tf-demo.com"]
emails          = ["noreply@akamai.com"]
activation_note = "Activated by Terraform"
network         = "STAGING"

# Protections
enable_waf                 = true
enable_request_constraints = true
enable_ip_geo              = true
enable_malware             = true
enable_rate                = true
enable_client_reputation   = true
enable_slow_post           = true
enable_bot_management      = true

# Global advanced settings
pragma_header_name  = "Show-Me-The-Pragma"
pragma_header_value = "v3Ry-5eCr3t-5tR1Ng"

# Specifics for the Security Policy
# Security Policy Details
policy_name   = "tf-demo"
policy_prefix = "TF01"

# IP/Geo Firewall
geo_network_lists          = ["215431_JAESCALOTFWAFGEOBL"]
ip_network_lists           = ["215434_JAESCALOTFWAFIPBLO"]
exception_ip_network_lists = ["214942_JAESCALOTFWAFSECURIT"]

# Dos Protection
dos_origin_error_action       = "deny"
dos_post_page_requests_action = "deny"
dos_page_view_requests_action = "deny"
slow_post_action              = "abort"

# Custom Rule Actions
custom_rules_by_id = {
  "60286975" = "alert" # Rule Name: Suspicious User Agent
  "60287284" = "deny"  # Rule Name: Suspicious User Agent 2
}
custom_bad_user_agent_action   = "deny"
custom_bad_user_agent_2_action = "deny"

# Web Application Firewall (WAF) Actions
waf_policy_action   = "deny"
waf_wat_action      = "deny"
waf_protocol_action = "deny"
waf_sql_action      = "deny"
waf_xss_action      = "deny"
waf_cmd_action      = "alert"
waf_lfi_action      = "deny"
waf_rfi_action      = "deny"
waf_platform_action = "deny"
penalty_box_action  = "alert"

# Client Reputation Actions
rep_web_attackers_high  = "deny"
rep_dos_attackers_high  = "deny"
rep_scanning_tools_high = "deny"
rep_web_attackers_low   = "alert"
rep_dos_attackers_low   = "deny"
rep_scanning_tools_low  = "alert"
rep_web_scrapers_low    = "alert"
rep_web_scrapers_high   = "deny"

# Bot Management General Settings
add_akamai_bot_header     = false
enable_active_detections  = true
enable_browser_validation = false
remove_botman_cookies     = false
third_party_proxy         = false

# Bot Category Actions
bot_site_monitoring_and_web_development = "monitor"
bot_academic_or_research                = "monitor"
bot_job_search_engine                   = "monitor"
bot_artificial_intelligence_ai          = "monitor"
bot_online_advertising                  = "monitor"
bot_ecommerce_search_engine             = "monitor"
bot_web_search_engine                   = "ignore"
bot_enterprise_data_aggregator          = "monitor"
bot_financial_services                  = "monitor"
bot_social_media_or_blog                = "monitor"
bot_automated_shopping_cart_and_sniper  = "monitor"
bot_web_archiver                        = "monitor"
bot_business_intelligence               = "monitor"
bot_news_aggregator                     = "monitor"
bot_rss_feed_reader                     = "monitor"
bot_financial_account_aggregator        = "monitor"
bot_media_or_entertainment_search       = "monitor"
bot_seo_analytics_or_marketing          = "monitor"

# Bot Transparent Detections Actions
bot_impersonators_of_known_bots            = "monitor"
bot_development_frameworks                 = "monitor"
bot_http_libraries                         = "monitor"
bot_web_services_libraries                 = "monitor"
bot_open_source_crawlersscraping_platforms = "monitor"
bot_headless_browsersautomation_tools      = "monitor"
bot_declared_bots_keyword_match            = "monitor"
bot_aggressive_web_crawlers                = "monitor"
bot_browser_impersonator                   = "monitor"
bot_web_scraper_reputation                 = "monitor"

# Bot Active Detections Actions
bot_cookie_integrity_failed                       = "monitor"
bot_session_validation                            = "monitor"
bot_client_disabled_javascript_noscript_triggered = "monitor"
bot_javascript_fingerprint_anomaly                = "monitor"
bot_javascript_fingerprint_not_received           = "monitor"




