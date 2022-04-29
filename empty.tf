/*
 * REQUIRED: This file allows both the non-creation and destruction of code as intended.
 *           Simply reference this file in your code to clear existing infrastructure.
 * 
 * This file is simply an empty file that will be used to destroy exiting infrastructure.
 * Without this file, the ternary code within the modules inside `_envcommon`, using `null`,
 * does not operate as intended.
 *
 * In short, this is a hack. It does however, help keep the code base clean of any lurking
 * files and my "IaC Life" free of misery.
 */
terraform {
  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.36.0 and above) recommends Terraform 1.1.4 or above.
  required_version = "= 1.1.4"

  # Live modules pin exact provider version; generic modules let consumers pin the version.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.7.0"
    }
  }
}
