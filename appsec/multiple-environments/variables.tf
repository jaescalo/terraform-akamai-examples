# Environment variables (TF_VAR_*)
variable "akamai_client_secret" {}
variable "akamai_host" {}
variable "akamai_access_token" {}
variable "akamai_client_token" {}
variable "akamai_account_key" {}

# -------------------------------------------------
# Common Variables 
# -------------------------------------------------
variable "environment" {
  description = "Environment (dev, qa, test)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "test"], var.environment)
    error_message = "Environment must be dev, qa, or test."
  }
}
variable "group_name" {
  description = "Akamai Group Name"
  type        = string
}
variable "config_name" {
  description = "Security configuration name"
  type        = string
}
variable "description" {
  default = "Security configuration description"
  type    = string
}
variable "hostnames" {
  description = "Hostnames to protect by the security config"
  type        = list(string)
}
variable "emails" {
  description = "List or emails for notifications"
  type        = list(string)
}
variable "activation_note" {
  description = "Notes for the activation"
  type        = string
}
variable "network" {
  description = "Activation network "
  type        = string
  validation {
    condition     = contains(["STAGING", "PRODUCTION"], var.network)
    error_message = "Activation network must be STAGING or PRODUCTION"
  }
}

# -------------------------------------------------
# Protections
# -------------------------------------------------
variable "enable_waf" {
  description = "Enable Web Application Firewall Protection"
  type        = bool
}
variable "enable_request_constraints" {
  description = "Enable API Requests Constraints Protection"
  type        = bool
}
variable "enable_ip_geo" {
  description = "Enable IP/Geo Firewall Protection"
  type        = bool
}
variable "enable_malware" {
  description = "Enable Malware Protection"
  type        = bool
}
variable "enable_rate" {
  description = "Enable Rate Protection"
  type        = bool
}
variable "enable_reputation" {
  description = "Enable Client Reputation Protection"
  type        = bool
}
variable "enable_slow_post" {
  description = "Enable Slow POST Protection"
  type        = bool
}
variable "enable_botman" {
  description = "Enable Bot Management Protection"
  type        = bool
}

# -------------------------------------------------
# Global advanced settings
# -------------------------------------------------
variable "pragma_header_name" {
  description = "Name for the header to match to expose pragma headers"
  type        = string
}
variable "pragma_header_value" {
  description = "Value for the header to match to expose pragma headers"
  type        = string
}

# -------------------------------------------------
# Specifics for the Security Policy
# -------------------------------------------------
# Security Policy Details
variable "policy_name" {
  description = "Name for the security policy"
  type        = string
}
variable "policy_prefix" {
  description = "Prefix for the security policy"
  type        = string
}

# IP/Geo Firewall
variable "ip_network_lists" {
  description = "List or IP Client/Network lists"
  type        = list(string)
}
variable "geo_network_lists" {
  description = "List of Geo Client/Network lists"
  type        = list(string)
}
variable "exception_ip_network_lists" {
  description = "List of block exceptions"
  type        = list(string)
}

# Dos Protection
variable "dos_origin_error_action" {
  description = "Action for the Origin Error"
  type        = string
}
variable "dos_post_page_requests_action" {
  description = "Action for the POST Page Requests"
  type        = string
}
variable "dos_page_view_requests_action" {
  description = "Action for the Page View Requests"
  type        = string
}
variable "slow_post_action" {
  description = "Action for the slow POST Protection"
  type        = string
}

# Custom Rule Actions by ID (commonly for XML rules)
variable "custom_rules_by_id" {
  description = "Map of custom rule IDs to their corresponding actions"
  type        = map(string)
}

# Custom Rule Actions
variable "custom_bad_user_agent_action" {
  description = "Action for custom rule: Bad User Agent"
  type        = string
}

# Web Application Firewall (WAF) Actions
variable "waf_policy_action" {
  description = "Action for WAF attack group: Web Policy Violation"
  type        = string
}
variable "waf_wat_action" {
  description = "Action for WAF attack group: Web Attack Tool"
  type        = string
}
variable "waf_protocol_action" {
  description = "Action for WAF attack group: Web Protocol Attack"
  type        = string
}
variable "waf_sql_action" {
  description = "Action for WAF attack group: SQL Injection"
  type        = string
}
variable "waf_xss_action" {
  description = "Action for WAF attack group: Cross Site Scripting"
  type        = string
}
variable "waf_cmd_action" {
  description = "Action for WAF attack group: Command Injection"
  type        = string
}
variable "waf_lfi_action" {
  description = "Action for WAF attack group: Local File Inclusion"
  type        = string
}
variable "waf_rfi_action" {
  description = "Action for WAF attack group: Remote File Inclusion"
  type        = string
}
variable "waf_platform_action" {
  description = "Action for WAF attack group: Web Platform Attack"
  type        = string
}
variable "penalty_box_action" {
  description = "Action for WAF Penalty Box"
  type        = string
}

# Client Reputation Actions
variable "rep_web_attackers_high" {
  description = "Action for Reputation Profile:  Web Attackers (High Threat)"
  type        = string
}
variable "rep_dos_attackers_high" {
  description = "Action for Reputation Profile: DoS Attackers (High Threat)"
  type        = string
}
variable "rep_scanning_tools_high" {
  description = "Action for Reputation Profile: Scanning Tools (High Threat)"
  type        = string
}
variable "rep_web_attackers_low" {
  description = "Action for Reputation Profile: Web Attackers (Low Threat)"
  type        = string
}
variable "rep_dos_attackers_low" {
  description = "Action for Reputation Profile: DoS Attackers (Low Threat)"
  type        = string
}
variable "rep_scanning_tools_low" {
  description = "Action for Reputation Profile: Scanning Tools (Low Threat)"
  type        = string
}
variable "rep_web_scrapers_low" {
  description = "Action for Reputation Profile: Web Scrapers (Low Threat)"
  type        = string
}
variable "rep_web_scrapers_high" {
  description = "Action for Reputation Profile: Web Scrapers (High Threat)"
  type        = string
}

# Bot Category Actions
variable "bot_site_monitoring_and_web_development" {
  description = "Action for Akamai Bot Category: Site Monitoring and Web Development Bots"
  type        = string
}
variable "bot_academic_or_research" {
  description = "Action for Akamai Bot Category: Academic or Research Bots"
  type        = string
}
variable "bot_job_search_engine" {
  description = "Action for Akamai Bot Category: Job Search Engine Bots"
  type        = string
}
variable "bot_artificial_intelligence_ai" {
  description = "Action for Akamai Bot Category: Artificial Intelligence (AI) Bots"
  type        = string
}
variable "bot_online_advertising" {
  description = "Action for Akamai Bot Category: Online Advertising Bots"
  type        = string
}
variable "bot_ecommerce_search_engine" {
  description = "Action for Akamai Bot Category: E-Commerce Search Engine Bots"
  type        = string
}
variable "bot_web_search_engine" {
  description = "Action for Akamai Bot Category: Web Search Engine Bots"
  type        = string
}
variable "bot_enterprise_data_aggregator" {
  description = "Action for Akamai Bot Category: Enterprise Data Aggregator Bots"
  type        = string
}
variable "bot_financial_services" {
  description = "Action for Akamai Bot Category: Financial Services Bots"
  type        = string
}
variable "bot_social_media_or_blog" {
  description = "Action for Akamai Bot Category: Social Media or Blog Bots"
  type        = string
}
variable "bot_automated_shopping_cart_and_sniper" {
  description = "Action for Akamai Bot Category: Automated Shopping Cart and Sniper Bots"
  type        = string
}
variable "bot_web_archiver" {
  description = "Action for Akamai Bot Category: Web Archiver Bots"
  type        = string
}
variable "bot_business_intelligence" {
  description = "Action for Akamai Bot Category: Business Intelligence Bots"
  type        = string
}
variable "bot_news_aggregator" {
  description = "Action for Akamai Bot Category: News Aggregator Bots"
  type        = string
}
variable "bot_rss_feed_reader" {
  description = "Action for Akamai Bot Category: RSS Feed Reader Bots"
  type        = string
}
variable "bot_financial_account_aggregator" {
  description = "Action for Akamai Bot Category: Financial Account Aggregator Bots"
  type        = string
}
variable "bot_media_or_entertainment_search" {
  description = "Action for Akamai Bot Category: Media or Entertainment Search Bots"
  type        = string
}
variable "bot_seo_analytics_or_marketing" {
  description = "Action for Akamai Bot Category: SEO, Analytics or Marketing Bots"
  type        = string
}

# Bot Transparent Detections Actions
variable "bot_impersonators_of_known_bots" {
  description = "Action for Bot Transparent Detections: Impersonators of Known Bots "
  type        = string
}
variable "bot_development_frameworks" {
  description = "Action for Bot Transparent Detections: Development Frameworks "
  type        = string
}
variable "bot_http_libraries" {
  description = "Action for Bot Transparent Detections: HTTP Libraries "
  type        = string
}
variable "bot_web_services_libraries" {
  description = "Action for Bot Transparent Detections: Web Services Libraries "
  type        = string
}
variable "bot_open_source_crawlersscraping_platforms" {
  description = "Action for Bot Transparent Detections: Open Source Crawlers/Scraping Platforms "
  type        = string
}
variable "bot_headless_browsersautomation_tools" {
  description = "Action for Bot Transparent Detections: Headless Browsers/Automation Tools"
  type        = string
}
variable "bot_declared_bots_keyword_match" {
  description = "Action for Bot Transparent Detections: Declared Bots (Keyword Match) "
  type        = string
}
variable "bot_aggressive_web_crawlers" {
  description = "Action for Bot Transparent Detections: Aggressive Web Crawlers"
  type        = string
}
variable "bot_browser_impersonator" {
  description = "Action for Bot Transparent Detections: Browser Impersonator"
  type        = string
}
variable "bot_web_scraper_reputation" {
  description = "Action for Bot Transparent Detections: Web Scraper Reputation "
  type        = string
}

# Bot Active Detections Actions
variable "bot_cookie_integrity_failed" {
  description = "Bot Active Detections Actions: Cookie Integrity Failed "
  type        = string
}
variable "bot_session_validation" {
  description = "Bot Active Detections Actions: Session Validation "
  type        = string
}
variable "bot_client_disabled_javascript_noscript_triggered" {
  description = "Bot Active Detections Actions: Client Disabled JavaScript (Noscript Triggered)"
  type        = string
}
variable "bot_javascript_fingerprint_anomaly" {
  description = "Bot Active Detections Actions: JavaScript Fingerprint Anomaly"
  type        = string
}
variable "bot_javascript_fingerprint_not_received" {
  description = "Bot Active Detections Actions: JavaScript Fingerprint Not Received"
  type        = string
}





