output "client_id" {
  value       = azuread_application.aks.application_id
  description = "The client ID."
}

output "client_secret" {
  value       = azuread_service_principal_password.aks.value
  sensitive   = true
  description = "The client secret."
}