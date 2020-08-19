resource "newrelic_dashboard" "exampledash" {
  title = "APM Overview"

  # Determines who can edit the dashboard in an account. 
  # Valid values are all, editable_by_all, editable_by_owner, or read_only. 
  # Defaults to editable_by_all. 
  editable = "editable_by_all"
  
  # Determines who can see the dashboard in an account. 
  # Valid values are all or owner. 
  # Defaults to all.
  visibility = "all"

  # A nested block that describes a dashboard filter. 
  # Exactly one nested filter block is allowed.
  # The below is an exhaustive example for the eventType Transaction.
  # If you use custom_attributes, you may want to extend the below list.
  filter {
    event_types = [
        "Transaction"
    ]
    attributes = [
        "appName",
        "error",
        "httpResponseCode",
        "name",
        "port",
        "request.headers.userAgent",
        "request.method",
        "request.uri",
        "response.headers.contentType",
        "sampled",
        "traceId",
        "transactionSubType",
        "transactionType"
    ]
  }

  # The icon for the dashboard. 
  # Valid values are adjust, archive, bar-chart, bell, bolt, bug, bullhorn, bullseye, clock-o, cloud, cog, comments-o, crosshairs, 
  # dashboard, envelope, fire, flag, flask, globe, heart, leaf, legal, life-ring, line-chart, magic, mobile, money, none, paper-plane, 
  # pie-chart, puzzle-piece, road, rocket, shopping-cart, sitemap, sliders, tablet, thumbs-down, thumbs-up, trophy, usd, user, and users. 
  # Defaults to bar-chart.
  icon = "heart"

  # There are 2 types of Dashboards supported, classic Insights Dashboards with a 3 solumn
  # layout and NR One Dashboards with a 12 column layout. Supported values are 3 and 12.
  # Defaults to 3.
  grid_column_count = 12

  widget {
    title = "Dashboard Note"
    visualization = "markdown"
    source = "![Image](${var.logo_url})\n\n[k8s Cluster Explorer](https://one.eu.newrelic.com/launcher/k8s-cluster-explorer-nerdlet.cluster-explorer-launcher)\n\n[NR AI](https://one.eu.newrelic.com/launcher/nrai.launcher)"
    
    row = 1
    height = 2
    column = 1
    width = 2
  }

  widget {
    title = "Top 7 Slowest Apps (in ms)"
    visualization = "facet_bar_chart"
    nrql = "SELECT average(duration*1000) FROM Transaction FACET appName SINCE 15 minutes ago LIMIT 7"
    
    # only works hardcoded until https://github.com/newrelic/terraform-provider-newrelic/issues/322 is resolved.
    drilldown_dashboard_id = var.dashboard_id

    row = 1
    height = 5
    column = 3
    width = 2
  }

  widget {
    title = "Top 7 Error rate (in %)"
    visualization = "facet_bar_chart"
    nrql = "SELECT filter(count(*), WHERE error IS true)*100/count(*) AS 'Error percentage' FROM Transaction SINCE 15 minutes ago FACET appName LIMIT 7"
    
    # only works hardcoded until https://github.com/newrelic/terraform-provider-newrelic/issues/322 is resolved.
    drilldown_dashboard_id = var.dashboard_id

    row = 1
    height = 5
    column = 5
    width = 2
  }

  widget {
    title = "Current App Response time"
    visualization = "gauge"
    nrql = "SELECT average(duration*1000) AS 'Average (ms)' FROM Transaction SINCE 15 minutes ago"

    threshold_red = var.app_duration_sla

    row = 1
    height = 2
    column = 7
    width = 3
  }

  widget {
    title = "Current App Error percentage"
    visualization = "gauge"
    nrql = "SELECT filter(count(*), WHERE error IS true)*100/count(*) AS 'Error percentage' FROM Transaction SINCE 15 minutes ago"

    threshold_red = var.app_error_sla

    row = 1
    height = 2
    column = 10
    width = 3
  }
  
  widget {
    title = "Current DB Response Time"
    visualization = "gauge"
    nrql = "SELECT average(databaseDuration*1000) AS 'Average (ms)' FROM Transaction SINCE 15 minutes ago"

    threshold_red = var.db_duration_sla

    row = 3
    height = 2
    column = 1
    width = 2
  }
  
  widget {
    title = "Current 3rd Party Response Time"
    visualization = "gauge"
    nrql = "SELECT average(externalDuration*1000) AS 'Average (ms)' FROM Transaction SINCE 15 minutes ago"

    threshold_red = var.third_party_duration_sla

    row = 5
    height = 2
    column = 1
    width = 2
  }

  widget {
    title = "Non 20x HTTP rate"
    visualization = "gauge"
    nrql = "SELECT filter(count(*), WHERE httpResponseCode NOT LIKE '20%')*100/count(*) AS 'Non 20x' FROM Transaction SINCE 15 minutes ago"

    threshold_red = var.non_http_20x_rate

    row = 7
    height = 2
    column = 1
    width = 2
  }

  widget {
    title = "App Error percentage - Average, and SLA (${var.app_error_sla} %) - week over week"
    visualization = "line_chart"
    nrql = "SELECT filter(count(*), WHERE error IS true)*100/count(*) AS 'Error percentage', ${var.app_error_sla} AS 'SLA' FROM Transaction SINCE 1 week ago TIMESERIES AUTO COMPARE WITH 1 week ago"
    
    row = 3
    height = 3
    column = 7
    width = 3
  }

  widget {
    title = "App Response Time - Average, Top 90%, and SLA (${var.app_duration_sla} ms) - week over week"
    visualization = "line_chart"
    nrql = "SELECT average(duration*1000) AS 'Average', percentile(duration*1000, 90) AS 'Top', ${var.app_duration_sla} AS 'SLA' FROM Transaction SINCE 1 week ago TIMESERIES AUTO COMPARE WITH 1 week ago"
    
    row = 3
    height = 3
    column = 10
    width = 3
  }

  widget {
    title = "Database Response Time - Average, Top 90%, and SLA (${var.db_duration_sla} ms) - week over week"
    visualization = "line_chart"
    nrql = "SELECT average(externalDuration*1000) AS 'Average (ms)', percentile(externalDuration*1000, 90) AS 'Top 90% (ms)', ${var.db_duration_sla} AS 'SLA' FROM Transaction SINCE 1 week ago TIMESERIES AUTO COMPARE WITH 1 week ago"
    
    row = 6
    height = 3
    column = 7
    width = 3
  }

  widget {
    title = "Throughput by HTTP Response Code"
    visualization = "faceted_area_chart"
    nrql = "SELECT count(*) FROM Transaction SINCE 1 week ago FACET httpResponseCode TIMESERIES AUTO LIMIT 20"
    
    row = 6
    height = 3
    column = 10
    width = 3
  }

  widget {
    title = "Apdex Top 5 Apps"
    visualization = "faceted_line_chart"
    nrql = "SELECT apdex(duration*1000, t: ${var.app_duration_sla}) FROM Transaction SINCE 1 week ago FACET appName TIMESERIES AUTO LIMIT 5"
    
    row = 6
    height = 3
    column = 3
    width = 4
  }

  widget {
    title = "Throughput per Apdex-Zone"
    visualization = "faceted_area_chart"
    nrql = "SELECT count(*) FROM Transaction SINCE 1 week ago FACET apdexPerfZone TIMESERIES AUTO"
    
    row = 9
    height = 3
    column = 1
    width = 3
  }

  widget {
    title = "Throughput by Function"
    visualization = "facet_bar_chart"
    nrql = "SELECT count(*) FROM Transaction SINCE 1 week ago FACET name limit 50"
    
    # only works hardcoded until https://github.com/newrelic/terraform-provider-newrelic/issues/322 is resolved.
    drilldown_dashboard_id = var.dashboard_id

    row = 9
    height = 3
    column = 4
    width = 5
  }

  widget {
    title = "HTTP response codes"
    visualization = "facet_pie_chart"
    nrql = "SELECT count(*) FROM Transaction SINCE 1 week ago FACET httpResponseCode limit 50"
    
    # only works hardcoded until https://github.com/newrelic/terraform-provider-newrelic/issues/322 is resolved.
    drilldown_dashboard_id = var.dashboard_id

    row = 9
    height = 3
    column = 9
    width = 4
  }

  widget {
    title = "Throughput by Host"
    visualization = "facet_pie_chart"
    nrql = "SELECT count(*) FROM Transaction SINCE 1 week ago FACET host limit 50"
    
    # only works hardcoded until https://github.com/newrelic/terraform-provider-newrelic/issues/322 is resolved.
    drilldown_dashboard_id = var.dashboard_id

    row = 12
    height = 3
    column = 1
    width = 6
  }

widget {
    title = "Throughput per Host"
    visualization = "faceted_area_chart"
    nrql = "SELECT count(*) FROM Transaction SINCE 1 week ago FACET host TIMESERIES AUTO LIMIT 20"
    
    row = 12
    height = 3
    column = 7
    width = 6
  }

  # widget {
  #   title = "Apdex, top 5 by host"
  #   duration = 1800000
  #   visualization = "metric_line_chart"
  #   # entity_ids = [
  #   #   data.newrelic_application.my_application.id,
  #   # ]
  #   metric {
  #       name = "Apdex"
  #       values = [ "score" ]
  #   }
  #   facet = "host"
  #   limit = 5
  #   row = 2
  #   column = 1
  # }
}