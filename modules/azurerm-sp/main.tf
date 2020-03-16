# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A SERVICE PRINCIPAL IN AZURE
# These templates show an example of how to deploy a service principal in Azure.
# ---------------------------------------------------------------------------------------------------------------------
provider "azuread" {
  version         = ">= 0.7.0"
  subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

terraform {
  required_version = ">= 0.12.0"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE NECESSARY AZURE AD RESOURCES FOR THE EXAMPLE
# ---------------------------------------------------------------------------------------------------------------------
resource "azuread_application" "aks" {
  name = "sp-app-aks"
}

# NOTE: SP only supports a list of tags instead of a key=value map
resource "azuread_service_principal" "aks" {
  application_id = azuread_application.aks.application_id

  depends_on = [azuread_application.aks]

  # TODO: use map keys -> list conversion
  tags = var.tags_list
}