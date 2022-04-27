locals {
  # When set to false will either: not create; or destroy the environment.
  non_prod_enabled = true

  # Each component when set to false will either: not create; or destroy the component.
  mysql_enabled    = true
  web_enabled      = false
}
