# Global settings
variable "config_id" {
  default = "Akamai security configuration ID"
  type    = string
}
variable "security_policy_id" {
  description = "Security policy ID"
  type        = string
}
variable "add_akamai_bot_header" {
  description = "Adds a header named Akamai-Bot to bot request forwarded to the origin. The header contains details like: bot type, Botnet ID, action, detection method, and bot score details, if applicable"
  type        = bool
}
variable "enable_active_detections" {
  description = "These methods interact with the requesting client using a combination of JavaScript and cookies to try to confirm that the request comes from a human using a real web browser"
  type        = bool
}
variable "enable_browser_validation" {
  description = "Confirm that requests come from a browser. Enable use browser validation detection anywhere you expect browsers to visit the URL"
  type        = bool
}
variable "remove_botman_cookies" {
  description = "Remove Bot Manager cookies before sending request to origin"
  type        = bool
}
variable "third_party_proxy" {
  description = "If you use a third-party proxy service between two Akamai Edge servers for things like A/B testing, content translation, or content adaption engines, turn this on to improve detection accuracy"
  type        = bool
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
