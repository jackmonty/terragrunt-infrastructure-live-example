# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  # Automatically load enabled variables
  enabled_vars = read_terragrunt_config(find_in_parent_folders("enabled.hcl"))

  account_name    = "non-prod"
  aws_account_id  = "270463201375" # TODO: replace me with your AWS account ID!
  aws_profile     = "non-prod"
  account_enabled = local.enabled_vars.locals.non_prod_enabled
}
