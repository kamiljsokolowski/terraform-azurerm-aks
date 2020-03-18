output "id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "The Kubernetes Managed Cluster ID."
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  description = "The Kubernetes kubeconfig file."
}

output "client_key" {
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
#   sensitive   = true
  description = "The private key used by clients to authenticate to the Kubernetes cluster."
}

output "client_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive   = true
  description = "The public certificate used by clients to authenticate to the Kubernetes cluster."
}

output "cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
  sensitive   = true
  description = "The public CA certificate used as the root of trust for the Kubernetes cluster."
}

output "host" {
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.host
  description = "The Kubernetes cluster server host."
}