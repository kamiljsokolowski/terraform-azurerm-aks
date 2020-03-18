# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------
variable "app_name" {
  description = "The name of the Application within Azure Active Directory."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "end_date_relative" {
  default = "8760h"
}

variable "role_definition_name" {
  default = ""
}

variable "scope" {
  default = ""
}

variable "tags_list"{
  type        = list(string)
  default     = ["app: Terraform module: Azure AD Service Principal",
                 "environment: dev",
                 "terraform: true"]
}