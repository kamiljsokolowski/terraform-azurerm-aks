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
  description = "The name of the Azure resource group Log Analytics solution will be deployed into. This RG should already exist"
}

variable "location" {
  description = "The Azure region Log Analytics solution will be deployed in"
  default = "westeurope"
}

variable "workspace_name" {
  description = "The name of the Log Analytics workspace to be deployed"
}

variable "solution_name" {
  description = "The name of the Log Analytics solution to be deployed"
}

variable "publisher" {
  description = "The name of the Log Analytics solution publisher"
}

variable "product" {
  description = "The name of the Log Analytics solution product"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "sku" {
  description = "Specify the workspace Sku"
  default     = "PerGB2018"
}

variable "retention" {
  description = "Specify the workspace data retention in days"
  default     = 30
}

variable "tags" {
  type = map(string)
  default = {
    "app"         = "Terraform module: Azure Log Analytics solution"
    "environment" = "dev"
    "terraform"   = "true"
  }
}