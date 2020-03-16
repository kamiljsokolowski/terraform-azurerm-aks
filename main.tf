# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A K8s CLUSTER IN AZURE USING AKS
# These templates show an example of how to deploy K8s cluster in Azure using AKS.
# ---------------------------------------------------------------------------------------------------------------------

provider "azurerm" {
  version         = "~> 2.0"
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
# CREATE THE NECESSARY NETWORK RESOURCES FOR THE EXAMPLE
# ---------------------------------------------------------------------------------------------------------------------
resource "azurerm_virtual_network" "aks" {
  name                = "vnet-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  # ddos_protection_plan {
  #   id     = "${azurerm_ddos_protection_plan.test.id}"
  #   enable = true
  # }

  tags = var.tags
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = var.resource_group_name
  address_prefix       = var.subnet_address
  virtual_network_name = azurerm_virtual_network.aks.name
  service_endpoints    = var.service_endpoints

  depends_on = [azurerm_virtual_network.aks]
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SERVICE PRINCIPAL
# ---------------------------------------------------------------------------------------------------------------------
module "service_principal" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "git::git@github.com:kamiljsokolowski/terraform-azurerm-aks.git//modules/azurerm-sp?ref=v0.0.1"
  source = "./modules/azurerm-sp"

  subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  role_definition_name  = "Network Contributor"
  scope                 = azurerm_subnet.aks.id
}