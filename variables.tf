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

variable "tags" {
  type = map(string)
  default = {
    "app"         = "Terraform module: AKS"
    "environment" = "dev"
    "terraform"   = "true"
  }
}