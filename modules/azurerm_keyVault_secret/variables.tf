variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created"
  type        = string
}
## This module creates a Key Vault secret in Azure Key Vault.

variable "secret_name" {
  type = string
  
}
variable "secret_value" {
  description = "The value of the secret"
  type        = string
  
}
variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}