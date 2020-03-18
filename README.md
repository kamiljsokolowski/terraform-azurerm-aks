# Kubernetes Azure Module
This repo contains a Module to deploy a [Kubernetes](https://kubernetes.io/) cluster on 
[Azure](https://azure.microsoft.com/) using [Terraform](https://www.terraform.io/). This Module uses [AKS](https://azure.microsoft.com/pl-pl/services/kubernetes-service/) PaaS cloud solution to host the cluster.

This Module includes:

* [azuread-app](https://github.com/kamiljsokolowski/terraform-azurerm-aks/tree/master/modules/azuread-app): Terraform code to deploy Azure Active Directory Application and Service Principal required by AKS to mange underlying resources i.e. provision nodes using Azure VMs.

* [monitoring](https://github.com/kamiljsokolowski/terraform-azurerm-aks/tree/master/modules/monitoring): Terraform code to create [Azure Monitor](https://azure.microsoft.com/en-us/services/monitor/) Log Analytics resources to collect logs from container workloads deployed to AKS.

## How do you use this Module?
### Basic example

```hcl
module "aks-k8s-cluster" {
  source   = "git::git@github.com:kamiljsokolowski/terraform-azurerm-aks.git?ref=0.9.0"
  
  subscription_id     = <your Azure subscription ID>
  tenant_id		      = <your Azure tenant ID>
  resource_group_name = <resource group name>
  vm_size             = "Standard_B2ms"
  max_pods            = 30
  os_disk_size_gb     = "32"
  admin_username      = <K8s node username>
  key_data            = <K8s node SSH public key>
}
```

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.0 |
| azuread | ~> 0.7 |
| random | >= 2.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| admin\_username | The Admin Username for the Cluster | `any` | n/a | yes |
| client\_id | The Azure client ID | `any` | n/a | yes |
| client\_secret | The Azure client secret key | `any` | n/a | yes |
| key\_data | The Public SSH Key used to access the cluster | `any` | n/a | yes |
| max\_pods | The maximum number of pods that can run on each node | `any` | n/a | yes |
| os\_disk\_size\_gb | The size of the OS Disk which should be used for each agent in the Node Pool | `any` | n/a | yes |
| resource\_group\_name | The name of the Azure resource group AKS K8s cluster will be deployed into. This RG should already exist | `any` | n/a | yes |
| subscription\_id | The Azure subscription ID | `any` | n/a | yes |
| tenant\_id | The Azure tenant ID | `any` | n/a | yes |
| vm\_size | The size of the Virtual Machine | `any` | n/a | yes |
| address\_space | The supernet for the resources that will be created | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| app\_name | The name of the Application within Azure Active Directory. | `string` | `"k8s-cluster"` | no |
| dns\_prefix | DNS prefix specified when creating the managed cluster | `string` | `"aks"` | no |
| enable\_auto\_scaling | Should the Kubernetes Auto Scaler be enabled for this Node Pool | `bool` | `false` | no |
| k8s\_version | Version of Kubernetes specified when creating the AKS managed cluster | `string` | `"1.14.8"` | no |
| location | The Azure region the AKS K8s cluster will be deployed in | `string` | `"westeurope"` | no |
| name | The name of the Managed Kubernetes Cluster to create. | `string` | `"k8s-cluster"` | no |
| node\_count | The initial number of nodes which should exist in this Node Pool | `string` | `"3"` | no |
| role\_based\_access\_control\_enabled | Is Role Based Access Control Enabled? | `bool` | `true` | no |
| service\_endpoints | The list of service endpoints for AKS subnet | `list(string)` | <pre>[<br>  "Microsoft.ContainerRegistry",<br>  "Microsoft.Storage",<br>  "Microsoft.KeyVault"<br>]</pre> | no |
| subnet\_address | The subnet that AKS resources will be deployed into | `list` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| tags | n/a | `map(string)` | <pre>{<br>  "app": "Terraform module: AKS",<br>  "environment": "dev",<br>  "terraform": "true"<br>}</pre> | no |
| type | The type of Node Pool which should be created | `string` | `"VirtualMachineScaleSets"` | no |
| workspace\_name | The name of the Log Analytics workspace to be deployed | `string` | `"k8s-cluster"` | no |

## Outputs

| Name | Description |
|------|-------------|
| client\_certificate | The public certificate used by clients to authenticate to the Kubernetes cluster. |
| client\_key | The private key used by clients to authenticate to the Kubernetes cluster. |
| cluster\_ca\_certificate | The public CA certificate used as the root of trust for the Kubernetes cluster. |
| host | The Kubernetes cluster server host. |
| id | The Kubernetes Managed Cluster ID. |
| kube\_config | The Kubernetes kubeconfig file. |
