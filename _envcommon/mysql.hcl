# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for mysql. The common variables for each environment to
# deploy mysql are defined here. This configuration will be merged into the environment configuration
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
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  enabled_vars = read_terragrunt_config(find_in_parent_folders("enabled.hcl"))
  
  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
  env-enabled = local.environment_vars.locals.enabled
  mysql-enabled = local.enabled_vars.locals.mysql_enabled

  # Expose the base source URL so different versions of the module can be deployed in different environments. 
  base_source_url = local.env-enabled && local.mysql-enabled ? "git::git@github-jackmonty:jackmonty/terragrunt-infrastructure-modules-example.git//mysql" : find_in_parent_folders("empty.tf")
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  name              = "mysql_${local.env}"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  storage_type      = "standard"
  master_username   = "admin"

  # TODO: To avoid storing your DB password in the code, set it as the environment variable TF_VAR_master_password
}
