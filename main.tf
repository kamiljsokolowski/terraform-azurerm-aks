# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A K8s CLUSTER IN AZURE USING AKS
# These templates show an example of how to deploy K8s cluster in Azure using AKS.
# ---------------------------------------------------------------------------------------------------------------------

provider "azurerm" {
  version         = ">=2.0"
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

terraform {
  required_version = ">= 0.12.0"
}
