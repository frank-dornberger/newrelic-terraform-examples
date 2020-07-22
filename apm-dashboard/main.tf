# For further details on how to write Dashboards using Terraform, please visit:
# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/dashboard

# The default environment variable is NEWRELIC_API_KEY and picked up if no 
# variable is set in the provider configuration. To be able to explicitly
# manage the variable and work with the below example, you can run this in 
# your CLI: export TF_VAR_my_admin_api_key=NRAA-0123456789abcdef
#

terraform {
  required_providers {
    newrelic = ">= 2.0.0"
  }
  required_version = ">= 0.12.0"
}

# The API URL is required, as it would otherwise default to the US region.
# Other values that can be set are found here: 
# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs#argument-reference
provider "newrelic" {
  account_id    = var.account_id
  admin_api_key = var.my_admin_api_key
  region        = var.region
}
