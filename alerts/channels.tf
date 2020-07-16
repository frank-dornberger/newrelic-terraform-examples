resource "newrelic_alert_channel" "email" {
  # If you dont want this resource, uncomment the below line.
  # count = 0
  name = var.channel_name != "" ? var.channel_name : "Example Email Channel"
  type = "email"

  config {
    #Required:
    recipients = var.email_recipients
    
    #Optional:
    include_json_attachment = var.email_include_json_attachment
  }
}

resource "newrelic_alert_channel" "slack" {
  # If you dont want this resource, uncomment the below line.
  count = 0
  name = var.channel_name != "" ? var.channel_name : "Example Slack Channel"
  type = "slack"

  config {
    #Required:
    url = var.slack_url

    #Optional:
    channel = var.slack_channel
  }
}

resource "newrelic_alert_channel" "opsgenie" {
  # If you dont want this resource, uncomment the below line.
  count = 0
  name = var.channel_name != "" ? var.channel_name : "Example OpsGenie Channel"
  type = "opsgenie"

  config {
    #Required:
    api_key = var.opsgenie_api_key
    region = var.opsgenie_region

    #Optional:
    teams = var.opsgenie_teams
    tags = var.opsgenie_tags
    recipients = var.opsgenie_recipients
  }
}

resource "newrelic_alert_channel" "pagerduty" {
  # If you dont want this resource, uncomment the below line.
  count = 0
  name = var.channel_name != "" ? var.channel_name : "Example PagerDuty Channel"
  type = "pagerduty"

  config {
    #Required:
    service_key = var.pagerduty_service_key
  }
}

resource "newrelic_alert_channel" "victorops" {
  # If you dont want this resource, uncomment the below line.
  count = 0
  name = var.channel_name != "" ? var.channel_name : "Example VictorOps Channel"
  type = "victorops"

  config {
    #Required:  
    key = var.victorops_key
    route_key = var.victorops_route_key
  }
}

resource "newrelic_alert_channel" "webhook" {
  # If you dont want this resource, uncomment the below line.
  count = 0
  name = var.channel_name != "" ? var.channel_name : "Example Webhook Channel"
  type = "webhook"

  config {
    #Required:
    base_url = var.webhook_base_url

    #Optional:
    auth_password = var.webhook_auth_password
    auth_type = var.webhook_auth_type
    auth_username = var.webhook_auth_username
    headers = var.webhook_headers
    headers_string = var.webhook_headers_string
    payload = var.webhook_payload
    payload_string = var.webhook_payload_string
    payload_type = var.webhook_payload_type
  }
}