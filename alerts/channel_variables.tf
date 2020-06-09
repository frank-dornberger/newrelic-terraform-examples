######################################
# EMAIL VARIABLES                    #
######################################

variable "email_include_json_attachment" {
  description = "Flag for whether or not to attach a JSON document containing information about the associated alert to the email that is sent to recipients. Options are \"0\" and \"1\". Defaults to \"0\"."
  default     = "0"
}

variable "email_recipients" {
  description = "A comma separated list of email addresses that should be notified, e.g. \"user1@example.com,user2@example.com\". No default."
}

######################################
# OPSGENIE VARIABLES                 #
######################################

variable "opsgenie_api_key" {
  description = "The API key for integrating with OpsGenie. No default."
}

variable "opsgenie_recipients" {
  description = "A set of recipients for targeting notifications. Multiple values are comma separated. Defaults to empty."
  default     = ""
}

variable "opsgenie_region" {
  description = "The data center region to store your data. Valid values are US and EU. Default is US."
  default     = "US"
}

variable "opsgenie_tags" {
  description = "A set of tags for targeting notifications. Multiple values are comma separated. Defaults to empty."
  default     = ""
}

variable "opsgenie_teams" {
  description = "A set of teams for targeting notifications. Multiple values are comma separated. Defaults to empty."
  default     = ""
}

######################################
# PAGERDUTY VARIABLES                #
######################################

variable "pagerduty_service_key" {
  description = "Specifies the service key for integrating with Pagerduty. No default."
}

######################################
# SLACK VARIABLES                    #
######################################

variable "slack_channel" {
  description = "The Slack channel to send notifications to. Defaults to empty."
  default     = ""
}

variable "slack_url" {
 description = "Your organization's Slack URL. No default."
}

######################################
# VICTOROPS VARIABLES                #
######################################

variable "victorops_key" {
  description = "The key for integrating with VictorOps. No default."
}

variable "victorops_route_key" {
  description = "The route key for integrating with VictorOps. No default."
}

######################################
# WEBHOOK VARIABLES                  #
######################################

variable "webhook_auth_password" {
  description = "Specifies an authentication password for use with a channel. Supported by the webhook channel type. Defaults to empty."
  default     = ""
}
variable "webhook_auth_type" {
  description = "Specifies an authentication method for use with a channel. Supported by the webhook channel type. Only HTTP basic authentication is currently supported via the value BASIC. Defaults to empty."
  default     = ""
}
variable "webhook_auth_username" {
  description = "Specifies an authentication username for use with a channel. Supported by the webhook channel type. Defaults to empty."
  default     = ""
}

variable "webhook_base_url" {
  description = "The base URL of the webhook destination. No default."
}

variable "webhook_headers" {
  description = "A map of key/value pairs that represents extra HTTP headers to be sent along with the webhook payload. Defaults to empty."
  default     = {}
  type        = map(string)
}

variable "webhook_headers_string" {
  description = "Use instead of headers if the desired payload is more complex than a list of key/value pairs (e.g. a set of headers that makes use of nested objects). The value provided should be a valid JSON string with escaped double quotes. Conflicts with headers. Defaults to empty."
  default     = ""
}

variable "webhook_payload" {
  description = "A map of key/value pairs that represents the webhook payload. Must provide payload_type if setting this argument. Defaults to empty."
  default     = {}
  type        = map(string)
}

variable "webhook_payload_string" {
  description = "Use instead of payload if the desired payload is more complex than a list of key/value pairs (e.g. a payload that makes use of nested objects). The value provided should be a valid JSON string with escaped double quotes. Conflicts with payload. Defaults to empty."
  default     = ""
}

variable "webhook_payload_type" {
  description = "Can either be application/json or application/x-www-form-urlencoded. The payload_type argument is required if payload is set. Defaults to empty."
  default     = ""
}