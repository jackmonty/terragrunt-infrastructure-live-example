# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for webserver-cluster. The common variables for each environment to
# deploy webserver-cluster are defined here. This configuration will be merged into the environment configuration
# via an include block.
# ---------------------------------------------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder. If any environment
# needs to deploy a different module version, it should redefine this block with a different ref to override the
# deployed version.
terraform {
  source = "${local.base_source_url}"
}  

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Automatically load account, environment and enablement variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  enabled_vars = read_terragrunt_config(find_in_parent_folders("enabled.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
  account-enabled = local.account_vars.locals.account_enabled
  web-enabled = local.enabled_vars.locals.web_enabled

  # Expose the base source URL so different versions of the module can be deployed in different environments.
  base_source_url = local.account-enabled && local.web-enabled ? "git::git@github-jackmonty:jackmonty/terragrunt-infrastructure-modules-example.git//asg-elb-service" : find_in_parent_folders("empty.tf")
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  name          = "webserver-example-${local.env}"
  instance_type = "t2.micro"

  min_size = 2
  max_size = 2

  server_port = 8080
  elb_port    = 80
}
