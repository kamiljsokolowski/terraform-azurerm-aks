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

# ---------------------------------------------------------------------------------------------------------------------
# CREATE LOG ANALYTICS SOLUTION
# ---------------------------------------------------------------------------------------------------------------------
module "log_analytics_solution" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "git::git@github.com:kamiljsokolowski/terraform-azurerm-aks.git//modules/azurerm-log-analytics?ref=v0.0.1"
  source = "./modules/azurerm-log-analytics"

  subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  location            = var.location
  resource_group_name = var.resource_group_name
  solution_name       = "ContainerInsights"
  publisher           = "Microsoft"
  product             = "OMSGallery/ContainerInsights"
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE K8S CLUSTER USING AKS
# ---------------------------------------------------------------------------------------------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.k8s_version
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name                = "default"
    vm_size             = var.vm_size
    # availability_zones  = ""
    enable_auto_scaling = var.enable_auto_scaling
    max_pods            = var.max_pods
    # node_taints         = ""
    os_disk_size_gb     = var.os_disk_size_gb
    type                = var.type
    vnet_subnet_id      = azurerm_subnet.aks.id
    # max_count           = ""
    # min_count           = ""
    node_count          = var.node_count

    # NOTE: adding tags will make the resource try to recreate/update itself each time -> BUG?
    # tags = var.tags
  }

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      key_data = var.key_data
    }
  }

  service_principal {
    client_id     = module.service_principal.client_id
    client_secret = module.service_principal.client_secret
  }

  role_based_access_control {
    enabled = var.role_based_access_control_enabled
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"
    # service_cidr       = ""
    # dns_service_ip     = ""
    # pod_cidr           = var.backend_k8s_cluster_net_pod_cidr
    # docker_bridge_cidr = ""
  }

  addon_profile {
    # http_application_routing {
    #   enabled = true
    # }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = module.log_analytics_solution.workspace_id
    }
  }

  depends_on = [azurerm_subnet.aks]

  tags = var.tags
}