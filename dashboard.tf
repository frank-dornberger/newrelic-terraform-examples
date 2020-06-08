resource "newrelic_dashboard" "exampledash" {
  title = "New Relic Terraform Example"

  # Determines who can edit the dashboard in an account. 
  # Valid values are all, editable_by_all, editable_by_owner, or read_only. 
  # Defaults to editable_by_all. 
  editable = "editable_by_all"
  
  # Determines who can see the dashboard in an account. 
  # Valid values are all or owner. 
  # Defaults to all.
  visibility = "all"

  ## A nested block that describes a dashboard filter. 
  ## Exactly one nested filter block is allowed.
  # filter {
  #   event_types = [
  #       "Transaction"
  #   ]
  #   attributes = [
  #       "appName",
  #       "name"
  #   ]
  # }

  # The icon for the dashboard. 
  # Valid values are adjust, archive, bar-chart, bell, bolt, bug, bullhorn, bullseye, clock-o, cloud, cog, comments-o, crosshairs, 
  # dashboard, envelope, fire, flag, flask, globe, heart, leaf, legal, life-ring, line-chart, magic, mobile, money, none, paper-plane, 
  # pie-chart, puzzle-piece, road, rocket, shopping-cart, sitemap, sliders, tablet, thumbs-down, thumbs-up, trophy, usd, user, and users. 
  # Defaults to bar-chart.
  icon = "heart"

  # There are 2 types of Dashboards supported, classic Insights Dashboards with a 3 solumn
  # layout and NR One Dashboards with a 12 column layout. Supported values are 3 and 12.
  grid_column_count = 12

  widget {
    title = "Dashboard Note"
    visualization = "markdown"
    source = "### Helpful Links\n\n* [New Relic One](https://one.newrelic.com)\n* [Developer Portal](https://developer.newrelic.com)"
    row = 1
    height = 2
    column = 1
    width = 2
  }

  widget {
    title = "Slowest Apps"
    visualization = "facet_bar_chart"
    nrql = "SELECT average(duration*1000) FROM Transaction FACET appName SINCE 15 minutes ago LIMIT 7"
    row = 1
    height = 5
    column = 3
    width = 2
  }

  widget {
    title = "Error rate"
    visualization = "facet_bar_chart"
    nrql = "SELECT filter(count(*), WHERE error IS true)*100/count(*) AS 'Error percentage' FROM Transaction SINCE 15 minutes ago FACET appName LIMIT 7"
    row = 1
    height = 5
    column = 5
    width = 2
  }

  widget {
    title = "Current App Response time"
    visualization = "gauge"
    nrql = "SELECT average(duration*1000) AS 'Average (ms)' FROM Transaction SINCE 15 minutes ago"

    threshold_red = 500

    row = 1
    height = 2
    column = 7
    width = 3
  }

  widget {
    title = "Current App Error percentage"
    visualization = "gauge"
    nrql = "SELECT filter(count(*), WHERE error IS true)*100/count(*) AS 'Error percentage' FROM Transaction SINCE 15 minutes ago"

    threshold_red = 0.5

    row = 1
    height = 2
    column = 10
    width = 3
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

  widget {
    title = "Requests per minute, by transaction"
    visualization = "facet_table"
    nrql = "SELECT rate(count(*), 1 minute) FROM Transaction FACET name"
    row = 2
    column = 2
  }
}