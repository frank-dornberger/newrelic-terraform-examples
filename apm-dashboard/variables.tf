variable "account_id" {
  description = "The default New Relic account ID to which the configs are to apply."
}

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

variable "non_http_20x_rate" {
  description = "The SLA in percents of your HTTP responses being non 20x. Default is 5"
  default     = 5
}

variable "region" {
  description = "The region of your New Relic account. Default is US."
  default     = "US"
}

variable "third_party_duration_sla" {
  description = "The SLA in ms of your 3rd party response time. Default 150"
  default     = 150
}