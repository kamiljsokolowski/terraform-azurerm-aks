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

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "end_date_relative" {
    default = "8760h"
}

variable "tags_list"{
  type        = list(string)
  default     = ["Terraform module: Azure AD Service Principal",
                 "dev",
                 "terraform"]
}