# To cofigure this example well, it's advised to look at this documentation:
# https://www.terraform.io/docs/providers/newrelic/r/alert_condition.html

data "newrelic_application" "app" {
  name = var.app_name
}

data "newrelic_key_transaction" "txn" {
  name = var.key_transaction_name
}

resource "newrelic_alert_policy" "policy" {
  name = var.policy_name
  incident_preference = var.policy_incident_preference
}

resource "newrelic_alert_condition" "apm_apdex" {
  # If this condition is not desired, set count = 0 or remove the resource.
  count = 1

  # Required
  policy_id = newrelic_alert_policy.policy.id
  name        = "${var.app_name}'s Apdex below ${var.apdex_threshold} for ${var.condition_duration} mins"
  type        = "apm_app_metric"
  entities    = [data.newrelic_application.app.id]
  metric      = "apdex"
  
  term {
    # Required
    duration      = var.condition_duration
    threshold     = var.apdex_threshold
    time_function = "all" # Options are all or any.

    # Optional
    operator      = "below" # Options are: above, below, or equal. Defaults to equal.
    priority      = "critical" # Options are: critical, or warning. Defaults to critical.
  }

  # Conditionally required (https://docs.newrelic.com/docs/alerts/new-relic-alerts/defining-conditions/scope-alert-thresholds-specific-instances)
  condition_scope = "application"
  
  # Optional
  enabled = var.maintenance == false ? true : false
  violation_close_timer = 24 # Options are: 1, 2, 4, 8, 12, or 24
  runbook_url = "https://www.example.com/runbook"

  lifecycle {
    ignore_changes = [
      violation_close_timer,
    ]
  }
}

resource "newrelic_alert_condition" "key_transaction_error_rate" {
  # If this condition is not desired, set count = 0 or remove the resource.
  count = 1

  # Required
  policy_id = newrelic_alert_policy.policy.id
  name        = "${var.key_transaction_name}'s Error rate above ${var.key_transaction_error_rate}% for ${var.condition_duration} mins"
  type        = "apm_kt_metric"
  entities    = [data.newrelic_key_transaction.txn.id]
  metric      = "error_percentage"
  
  term {
    # Required
    duration      = var.condition_duration
    threshold     = var.key_transaction_error_rate
    time_function = "all" # Options are all or any.

    # Optional
    operator      = "above" # Options are: above, below, or equal. Defaults to equal.
    priority      = "critical" # Options are: critical, or warning. Defaults to critical.
  }
  
  # Optional
  enabled = var.maintenance == false ? true : false
  violation_close_timer = 24 # Options are: 1, 2, 4, 8, 12, or 24
  runbook_url = "https://www.example.com/runbook"

  lifecycle {
    ignore_changes = [
      violation_close_timer,
    ]
  }
}

resource "newrelic_alert_condition" "browser_response_time" {
  # If this condition is not desired, set count = 0 or remove the resource.
  count = 1

  # Required
  policy_id = newrelic_alert_policy.policy.id
  name        = "Browser Page Load Time above ${var.browser_duration_threshold}s for ${var.condition_duration} mins"
  type        = "browser_metric"

  # for isolated Browser apps, it only works hardcoded until https://github.com/terraform-providers/terraform-provider-newrelic/issues/309 is resolved. 
  entities    = [var.browser_id]
  metric      = "total_page_load"
  
  term {
    # Required
    duration      = var.condition_duration
    threshold     = var.browser_duration_threshold
    time_function = "all" # Options are all or any.

    # Optional
    operator      = "above" # Options are: above, below, or equal. Defaults to equal.
    priority      = "critical" # Options are: critical, or warning. Defaults to critical.
  }

  # Optional
  enabled = var.maintenance == false ? true : false
  violation_close_timer = 24 # Options are: 1, 2, 4, 8, 12, or 24
  runbook_url = "https://www.example.com/runbook"

  lifecycle {
    ignore_changes = [
      violation_close_timer,
    ]
  }
}

resource "newrelic_alert_condition" "mobile_crash_rate" {
  # If this condition is not desired, set count = 0 or remove the resource.
  count = 0

  # Required
  policy_id = newrelic_alert_policy.policy.id
  name        = "Mobile's Crash rate above ${var.mobile_crash_rate}% for ${var.condition_duration} mins"
  type        = "mobile_metric"

  # for Mobile Browser apps, it only works hardcoded until NR provider 2.0 is released.
  entities    = [var.mobile_id]
  metric      = "mobile_crash_rate"
  
  term {
    # Required
    duration      = var.condition_duration
    threshold     = var.mobile_crash_rate
    time_function = "all" # Options are all or any.

    # Optional
    operator      = "above" # Options are: above, below, or equal. Defaults to equal.
    priority      = "critical" # Options are: critical, or warning. Defaults to critical.
  }

  # Optional
  enabled = var.maintenance == false ? true : false
  violation_close_timer = 24 # Options are: 1, 2, 4, 8, 12, or 24
  runbook_url = "https://www.example.com/runbook"

  lifecycle {
    ignore_changes = [
      violation_close_timer,
    ]
  }
}

# Enable the channels that you've configured.
resource "newrelic_alert_policy_channel" "channels_to_policy" {
  policy_id  = newrelic_alert_policy.policy.id
  channel_ids = [
    newrelic_alert_channel.email.id,
    # newrelic_alert_channel.slack.id,
    # newrelic_alert_channel.opsgenie.id,
    # newrelic_alert_channel.pagerduty.id,
    # newrelic_alert_channel.victorops.id,
    # newrelic_alert_channel.webhook.id,
  ]
}