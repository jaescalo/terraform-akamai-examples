# Common Variables 
variable "config_name" {}
variable "hostnames" {}
variable "description" {}
variable "contract_id" {}
variable "group_name" {}

# Protections
variable "enable_waf" {}
variable "enable_request_constraints" {}
variable "enable_ip_geo" {}
variable "enable_malware" {}
variable "enable_rate" {}
variable "enable_reputation" {}
variable "enable_slow_post" {}
variable "enable_botman" {}

# Global advanced settings
variable "pragma_header_name" {}
variable "pragma_header_value" {}

# Specifics for the Security Policy
# Security Policy Details
variable "policy_name" {}
variable "policy_prefix" {}

# IP/Geo Firewall
variable "ip_network_lists" {}
variable "geo_network_lists" {}
variable "exception_ip_network_lists" {}

# Dos Protection
variable "dos_origin_error_action" {}
variable "dos_post_page_requests_action" {}
variable "dos_page_view_requests_action" {}
variable "slow_post_action" {}

# Custom Rule Actions
variable "custom_rules_by_id" {}
variable "custom_bad_user_agent_action" {}
variable "custom_bad_user_agent_2_action" {}

# Web Application Firewall (WAF) Actions
variable "waf_policy_action" {}
variable "waf_wat_action" {}
variable "waf_protocol_action" {}
variable "waf_sql_action" {}
variable "waf_xss_action" {}
variable "waf_cmd_action" {}
variable "waf_lfi_action" {}
variable "waf_rfi_action" {}
variable "waf_platform_action" {}
variable "penalty_box_action" {}

# Client Reputation Actions
variable "rep_web_attackers_high" {}
variable "rep_dos_attackers_high" {}
variable "rep_scanning_tools_high" {}
variable "rep_web_attackers_low" {}
variable "rep_dos_attackers_low" {}
variable "rep_scanning_tools_low" {}
variable "rep_web_scrapers_low" {}
variable "rep_web_scrapers_high" {}

# Bot Category Actions
variable "bot_site_monitoring_and_web_development" {}
variable "bot_academic_or_research" {}
variable "bot_job_search_engine" {}
variable "bot_artificial_intelligence_ai" {}
variable "bot_online_advertising" {}
variable "bot_ecommerce_search_engine" {}
variable "bot_web_search_engine" {}
variable "bot_enterprise_data_aggregator" {}
variable "bot_financial_services" {}
variable "bot_social_media_or_blog" {}
variable "bot_automated_shopping_cart_and_sniper" {}
variable "bot_web_archiver" {}
variable "bot_business_intelligence" {}
variable "bot_news_aggregator" {}
variable "bot_rss_feed_reader" {}
variable "bot_financial_account_aggregator" {}
variable "bot_media_or_entertainment_search" {}
variable "bot_seo_analytics_or_marketing" {}

# Bot Transparent Detections Actions
variable "bot_impersonators_of_known_bots" {}
variable "bot_development_frameworks" {}
variable "bot_http_libraries" {}
variable "bot_web_services_libraries" {}
variable "bot_open_source_crawlersscraping_platforms" {}
variable "bot_headless_browsersautomation_tools" {}
variable "bot_declared_bots_keyword_match" {}
variable "bot_aggressive_web_crawlers" {}
variable "bot_browser_impersonator" {}
variable "bot_web_scraper_reputation" {}

# Bot Active Detections Actions
variable "bot_cookie_integrity_failed" {}
variable "bot_session_validation" {}
variable "bot_client_disabled_javascript_noscript_triggered" {}
variable "bot_javascript_fingerprint_anomaly" {}
variable "bot_javascript_fingerprint_not_received" {}




