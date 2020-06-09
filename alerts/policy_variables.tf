######################################
# GENERAL VARIABLES                  #
######################################

variable "maintenance" {
  description = "Defines whether Alert conditions are enabled or disabled. In maintenance mode, all conditions are disabled. Default is false"
  default     = false
  type        = bool
}

variable "my_admin_api_key" {
  description = "The New Relic Admin API key required to create Dashboards."
}

variable "new_relic_rest_api_url" {
  description = "The REST API Endpoint for your account. It depends on the regiof of your account. Options are https://api.newrelic.com/v2 or https://api.eu.newrelic.com/v2. Default is https://api.newrelic.com/v2"
  default     =  "https://api.newrelic.com/v2"
}

######################################
# ALERT POLICY VARIABLES             #
######################################

variable "channel_name" {
  description = "The name of an alert channel. Default depends to \"Example CHANNEL_TYPE Channel\"."
  default     = ""
}

variable "condition_duration" {
  description = "Defines for how many minutes a condition has to be violated before an alert is triggered. Defaults to 5"
  default     = 5
}

variable "policy_incident_preference" {
  description = "The rollup strategy for the policy. Options include: PER_POLICY, PER_CONDITION, or PER_CONDITION_AND_TARGET. Defaults to PER_POLICY"
  default     = "PER_POLICY"
}

variable "policy_name" {
  description = "The name of your policy. Defaults to \"Example policy (managed by Terraform)\"."
  default     = "Example policy (managed by Terraform)"
}

######################################
# APPLICATION VARIABLES              #
######################################

variable "app_name" {
  description = "The name of the app for which the policy will be generated. No default value."
}

variable "apdex_threshold" {
  description = "The Apdex value observed by the Alert condition. Defaults to 0.75"
  default     = "0.75"
}

######################################
# BROWSER VARIABLES                  #
######################################

variable "browser_duration_threshold" {
  description = "The total page load time in seconds observed by the Alert condition. Defaults to 7"
  default     = "7"
}

variable "browser_id" {
  description = "The ID of the browser app for which the policy will be generated. No default value."
}

######################################
# KEY TRANSACTION VARIABLES          #
######################################

variable "key_transaction_error_rate" {
  description = "The error rate (in %) observed by the Alert condition. Defaults to 0.5"
  default     = "0.5"
}

variable "key_transaction_name" {
  description = "The name of the key transaction for which the policy will be generated. No default value."
}

######################################
# MOBILE VARIABLES                   #
######################################

variable "mobile_id" {
  description = "The ID of the mobile app for which the policy will be generated. No default value."
}

variable "mobile_crash_rate" {
  description = "The crash rate (in %) observed by the Alert condition. Defaults to 1.0"
  default     = "1.0"
}