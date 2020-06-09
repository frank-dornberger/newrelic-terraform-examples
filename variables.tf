variable "app_duration_sla" {
  description = "The SLA in ms of your Application response time. Default 500"
  default = 500
}
variable "db_duration_sla" {
  description = "The SLA in ms of your DB response time. Default 100"
  default = 100
}

variable "logo_url" {
  description = "Logo of the Dashboard"
}

variable "my_admin_api_key" {
    description = "The New Relic Admin API key required to create Dashboards."
}
