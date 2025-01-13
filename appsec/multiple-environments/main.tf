data "akamai_contract" "contract" {
  group_name = var.group_name
}

module "security" {
  source      = "./modules/security"
  hostnames   = var.hostnames
  config_name = var.config_name
  description = var.description
  contract_id = data.akamai_contract.contract.id
  group_name  = var.group_name

  # Protections
  enable_waf                 = var.enable_waf
  enable_request_constraints = var.enable_request_constraints
  enable_ip_geo              = var.enable_ip_geo
  enable_malware             = var.enable_malware
  enable_rate                = var.enable_rate
  enable_slow_post           = var.enable_slow_post

  # Global advanced settings
  pragma_header_name  = var.pragma_header_name
  pragma_header_value = var.pragma_header_value

  # Specifics for the Security Policy
  # Security Policy Details
  policy_name   = var.policy_name
  policy_prefix = var.policy_prefix

  # IP/Geo Firewall
  geo_network_lists          = var.geo_network_lists
  ip_network_lists           = var.ip_network_lists
  exception_ip_network_lists = var.exception_ip_network_lists

  # Dos Protection
  dos_origin_error_action       = var.dos_origin_error_action
  dos_post_page_requests_action = var.dos_post_page_requests_action
  dos_page_view_requests_action = var.dos_page_view_requests_action
  slow_post_action              = var.slow_post_action

  # Custom Rule Actions
  custom_rules_by_id             = var.custom_rules_by_id
  custom_bad_user_agent_action   = var.custom_bad_user_agent_action
  custom_bad_user_agent_2_action = var.custom_bad_user_agent_2_action

  # Web Application Firewall (WAF) Actions
  waf_policy_action   = var.waf_policy_action
  waf_wat_action      = var.waf_wat_action
  waf_protocol_action = var.waf_protocol_action
  waf_sql_action      = var.waf_sql_action
  waf_xss_action      = var.waf_xss_action
  waf_cmd_action      = var.waf_cmd_action
  waf_lfi_action      = var.waf_lfi_action
  waf_rfi_action      = var.waf_rfi_action
  waf_platform_action = var.waf_platform_action
  penalty_box_action  = var.penalty_box_action
}

module "client-reputation" {
  count = var.enable_client_reputation ? 1 : 0

  source             = "./modules/client-reputation"
  config_id          = module.security.config_id
  security_policy_id = module.security.security_policy_id

  # Client Reputation Actions
  rep_web_attackers_high  = var.rep_web_attackers_high
  rep_dos_attackers_high  = var.rep_dos_attackers_high
  rep_scanning_tools_high = var.rep_scanning_tools_high
  rep_web_attackers_low   = var.rep_web_attackers_low
  rep_dos_attackers_low   = var.rep_dos_attackers_low
  rep_scanning_tools_low  = var.rep_scanning_tools_low
  rep_web_scrapers_low    = var.rep_web_scrapers_low
  rep_web_scrapers_high   = var.rep_web_scrapers_high
}

module "bot-manager" {
  count = var.enable_bot_management ? 1 : 0

  source             = "./modules/bot-manager"
  config_id          = module.security.config_id
  security_policy_id = module.security.security_policy_id

  add_akamai_bot_header     = var.add_akamai_bot_header
  enable_active_detections  = var.enable_active_detections
  enable_browser_validation = var.enable_browser_validation
  remove_botman_cookies     = var.remove_botman_cookies
  third_party_proxy         = var.third_party_proxy

  # Bot Category Actions
  bot_site_monitoring_and_web_development = var.bot_site_monitoring_and_web_development
  bot_academic_or_research                = var.bot_academic_or_research
  bot_job_search_engine                   = var.bot_job_search_engine
  bot_artificial_intelligence_ai          = var.bot_artificial_intelligence_ai
  bot_online_advertising                  = var.bot_online_advertising
  bot_ecommerce_search_engine             = var.bot_ecommerce_search_engine
  bot_web_search_engine                   = var.bot_web_search_engine
  bot_enterprise_data_aggregator          = var.bot_enterprise_data_aggregator
  bot_financial_services                  = var.bot_financial_services
  bot_social_media_or_blog                = var.bot_social_media_or_blog
  bot_automated_shopping_cart_and_sniper  = var.bot_automated_shopping_cart_and_sniper
  bot_web_archiver                        = var.bot_web_archiver
  bot_business_intelligence               = var.bot_business_intelligence
  bot_news_aggregator                     = var.bot_news_aggregator
  bot_rss_feed_reader                     = var.bot_rss_feed_reader
  bot_financial_account_aggregator        = var.bot_financial_account_aggregator
  bot_media_or_entertainment_search       = var.bot_media_or_entertainment_search
  bot_seo_analytics_or_marketing          = var.bot_seo_analytics_or_marketing

  # Bot Transparent Detections Actions
  bot_impersonators_of_known_bots            = var.bot_impersonators_of_known_bots
  bot_development_frameworks                 = var.bot_development_frameworks
  bot_http_libraries                         = var.bot_http_libraries
  bot_web_services_libraries                 = var.bot_web_services_libraries
  bot_open_source_crawlersscraping_platforms = var.bot_open_source_crawlersscraping_platforms
  bot_headless_browsersautomation_tools      = var.bot_headless_browsersautomation_tools
  bot_declared_bots_keyword_match            = var.bot_declared_bots_keyword_match
  bot_aggressive_web_crawlers                = var.bot_aggressive_web_crawlers
  bot_browser_impersonator                   = var.bot_browser_impersonator
  bot_web_scraper_reputation                 = var.bot_web_scraper_reputation

  # Bot Active Detections Actions
  bot_cookie_integrity_failed                       = var.bot_cookie_integrity_failed
  bot_session_validation                            = var.bot_session_validation
  bot_client_disabled_javascript_noscript_triggered = var.bot_client_disabled_javascript_noscript_triggered
  bot_javascript_fingerprint_anomaly                = var.bot_javascript_fingerprint_anomaly
  bot_javascript_fingerprint_not_received           = var.bot_javascript_fingerprint_not_received

  depends_on = [module.security]
}

module "activate-security" {
  source              = "./modules/activate-security"
  config_name         = var.config_name
  config_id           = module.security.config_id
  network             = var.network
  notification_emails = var.emails
  note                = var.activation_note
  depends_on = [
    module.security,
    module.bot-manager
  ]
}
