# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A LOG ANALYTICS SOLUTION IN AZURE
# These templates show an example of how to deploy Log Analytics in Azure.
# ---------------------------------------------------------------------------------------------------------------------
provider "azurerm" {
  version         = ">= 2.0"
  subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}

terraform {
  required_version = ">= 0.12.0"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE LOG ANALYTICS WORKSPACE
# ---------------------------------------------------------------------------------------------------------------------
# TODO: (as this is suppose to be a re-usable snippet) change resource name to something more generic
resource "azurerm_log_analytics_workspace" "aks" {
  name                = "loganal-ws-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention

  tags = var.tags
}