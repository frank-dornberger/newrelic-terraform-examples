variable "app_duration_sla" {
  description = "The SLA in ms of your Application response time. Default 500"
  default     = 500
}

variable "app_error_sla" {
  description = "The SLA in percents of your Application error rate. Default is 0.5"
  default     = 0.5
}

variable "dashboard_id" {
  description = "The ID of the Dashboard to apply the filter to. No default value possible."
}

variable "db_duration_sla" {
  description = "The SLA in ms of your DB response time. Default 100"
  default     = 100
}

variable "logo_url" {
  description = "Logo of the Dashboard"
}

variable "my_admin_api_key" {
  description = "The New Relic Admin API key required to create Dashboards."
}

variable "new_relic_rest_api_url" {
  description = "The REST API Endpoint for your account. It depends on the regiof of your account. Options are https://api.newrelic.com/v2 or https://api.eu.newrelic.com/v2. Default is https://api.newrelic.com/v2"
  default     =  "https://api.newrelic.com/v2"
}

variable "non_http_20x_rate" {
  description = "The SLA in percents of your HTTP responses being non 20x. Default is 5"
  default     = 5
}

variable "third_party_duration_sla" {
  description = "The SLA in ms of your 3rd party response time. Default 150"
  default     = 150
}