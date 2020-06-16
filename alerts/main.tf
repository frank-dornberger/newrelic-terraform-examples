# For further details on how to write Dashboards using Terraform, please visit:
# https://www.terraform.io/docs/providers/newrelic/r/dashboard.html


# The default environment variable is NEWRELIC_API_KEY and picked up if no 
# variable is set in the provider configuration. To be able to explicitly
# manage the variable and work with the below example, you can run this in 
# your CLI: export TF_VAR_my_admin_api_key=NRAA-0123456789abcdef
#

terraform {
  required_providers {
    newrelic = ">= 1.19.0"
  }
  required_version = ">= 0.12.0"
}
# The API URL is required, as it would otherwise default to the US region.
# Other values that can be set are found here: 
# https://www.terraform.io/docs/providers/newrelic/index.html#argument-reference
provider "newrelic" {
  api_key = var.my_admin_api_key
  api_url = var.new_relic_rest_api_url
}

# data "newrelic_application" "my_application" {
#   name = "My Application"
# }
