# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.9.0] - 2020-03-18

### Added
- Ability to utilize existing resource group
- Azure Virtual network definition
- Azure Subnet definition
- Submodule that will deploy a Azure AD App and SP
- Submodule that will deploy a Azure Monitor Log Analytics workspace and solution
- AKS-managed K8s cluster definition
- Output kubeconfig file content
- `CHANGELOG.md`

### Changed
- Switch resource name values from hardcoded to variables
- Rewrite `azurerm_role_assignment` resource definition as conditional
- Rewrite `client_id` and `client_secret` variable definition as optional to support authentication via Azure CLI 
- Re-factor provider definitions to utilize `Terraform`' 0.12 new features
- Update `README.md`

## [0.0.1] - 2020-03-10

### Added
- `README.md`
- `LICENSE`
- List of files not to be included under version control

[unreleased]: https://github.com/kamiljsokolowski/terraform-azurerm-aks/compare/v0.9.0...HEAD
[0.9.0]: https://github.com/kamiljsokolowski/terraform-azurerm-aks/compare/v0.0.1...v0.9.0