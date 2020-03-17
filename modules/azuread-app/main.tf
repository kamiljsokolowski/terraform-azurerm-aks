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

provider "azurerm" {
  version         = ">= 2.0"
  subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}

provider "random" {
  version = ">= 2.2.0"
}

terraform {
  required_version = ">= 0.12.0"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE NECESSARY AZURE AD RESOURCES FOR THE EXAMPLE
# ---------------------------------------------------------------------------------------------------------------------
# TODO: (as this is suppose to be a re-usable snippet) change resource name to something more generic
resource "azuread_application" "aks" {
  name = var.app_name
}

# NOTE: SP only supports a list of tags instead of a key=value map
resource "azuread_service_principal" "aks" {
  application_id = azuread_application.aks.application_id

  depends_on = [azuread_application.aks]

  # TODO: use map keys -> list conversion
  tags = var.tags_list
}

# NOTE: passwd will be generated on each run
resource "random_password" "secret" {
  length  = 32
  special = true

  keepers = {
    # Generate a new passwd each time we switch to a new SP
    aks = azuread_service_principal.aks.id
  }
}

resource "azuread_service_principal_password" "aks" {
  service_principal_id = azuread_service_principal.aks.id
  value                = random_password.secret.result
  # TODO: generate end date & relative end date
  end_date_relative    = var.end_date_relative                                             # NOTE: password will be valid for 1 year

  # TODO: (with passwd keeper defined) is this still valid?
  lifecycle {
    ignore_changes = [
      value,
      end_date_relative,
    ]
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }

  depends_on = [azuread_service_principal.aks,
                random_password.secret]
}

resource "azurerm_role_assignment" "aks" {
  principal_id         = azuread_service_principal.aks.id
  role_definition_name = var.role_definition_name
  scope                = var.scope

  depends_on = [azuread_service_principal.aks,
                azuread_service_principal_password.aks]
}