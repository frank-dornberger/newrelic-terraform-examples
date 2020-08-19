# newrelic-terraform-examples

## Introduction
If you haven't worked with Terraform before, you may want to read this article: https://www.terraform.io/intro/index.html

## Overview
The goal of this repo is to have a collection of ready made examples hot to use Terraform to configure various resources within New Relic, e.g. Dashboards, Alerts, Workloads, Synthetics Checks, etc. Each of the examples comes with its own README that further explains the use case and usage.

**The examples don't come with a configuration for the Terraform backend, which you may want to consider adding before applying the config as is to ensure the state file is available to others in your team.**

## Requirements
To be able to use any of the examples, you have to have 

* an active New relic account
* have an active subscription for the kind of data that is required in each example. Free tiers will work but may have limited data available
* possess the required API key(s), e.g. personal API key or Admin API key.

## Configuration
The examples are built in a way that they allow for flexible configuration but also come with a set of default assumptions that will kick in whenever no configuration is set, e.g. the account region being US.

It is advised that you have a look at the `variables.tf` file of each example to understand what variables are being used and what default values are assumed if not provided.

You can specify the values for each of them in a `terraform.tfvars` file to be automatically picked up. Details on that can be found here: https://learn.hashicorp.com/tutorials/terraform/aws-variables#from-a-file
Alternatively, you can set all variables via environment variables by using the `TF_VAR_`-prefix, e.g. the `my_admin_api_key` variable as such:

```bash
export TF_VAR_my_admin_api_key=NRAA-0123456789abcdef
```

If you don't provide a `terraform.tfvars`, are not using environment variables, or any of the alternative input options, and there are no default values available, you'll be prompted to supply a value before you can apply it.