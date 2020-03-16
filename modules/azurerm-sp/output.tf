output "client_id" {
  value       = azuread_application.aks.application_id
  description = "The client ID."
}
