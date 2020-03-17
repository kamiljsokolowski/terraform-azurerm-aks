# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------
variable "subscription_id" {
  description = "The Azure subscription ID"
}

variable "tenant_id" {
  description = "The Azure tenant ID"
}

# variable "client_id" {
#   description = "The Azure client ID"
# }

# variable "client_secret" {
#   description = "The Azure client secret key"
# }

variable "resource_group_name" {
  description = "The name of the Azure resource group AKS K8s cluster will be deployed into. This RG should already exist"
}

variable "vm_size" {
  description = "The size of the Virtual Machine"
}

variable "max_pods" {
  description = "The maximum number of pods that can run on each node"
}

variable "os_disk_size_gb" {
  description = "The size of the OS Disk which should be used for each agent in the Node Pool"
}

variable "admin_username" {
  description = "The Admin Username for the Cluster"
}

variable "key_data" {
  description = "The Public SSH Key used to access the cluster"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "location" {
  description = "The Azure region the AKS K8s cluster will be deployed in"
  default = "westeurope"
}

variable "address_space" {
  type        = list(string)
  description = "The supernet for the resources that will be created"
  default     = ["10.0.0.0/16"]
}

variable "subnet_address" {
  description = "The subnet that AKS resources will be deployed into"
  default     = ["10.0.0.0/16"]
}

variable "service_endpoints" {
  type        = list(string)
  description = "The list of service endpoints for AKS subnet"
  default     = ["Microsoft.ContainerRegistry",
                 "Microsoft.Storage",
                 "Microsoft.KeyVault"]
}

variable "app_name" {
  description = "The name of the Application within Azure Active Directory."
  default     = "k8s-cluster"
}

variable "workspace_name" {
  description = "The name of the Log Analytics workspace to be deployed"
  default     = "k8s-cluster"
}

variable "k8s_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
  default     = "1.14.8"
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster"
  default     = "aks"
}

variable "enable_auto_scaling" {
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool"
  default     = false
}

variable "type" {
  description = "The type of Node Pool which should be created"
  default     = "VirtualMachineScaleSets"
}

variable "node_count" {
  description = "The initial number of nodes which should exist in this Node Pool"
  default     = "3"
}

variable "role_based_access_control_enabled" {
  description = "Is Role Based Access Control Enabled?"
  default     = true
}

variable "tags" {
  type = map(string)
  default = {
    "app"         = "Terraform module: AKS"
    "environment" = "dev"
    "terraform"   = "true"
  }
}