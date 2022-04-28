locals {
  # When set to false will either: not create; or destroy the account resources.
  non_prod_enabled = false

  # Each component when set to false will either: not create; or destroy the component.
  mysql_enabled    = false
  web_enabled      = false
}
