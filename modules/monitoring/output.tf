output "workspace_id" {
  value       = azurerm_log_analytics_workspace.aks.id
  description = "The Log Analytics Workspace ID."
}