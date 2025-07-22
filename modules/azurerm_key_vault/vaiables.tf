
variable "key_vault_name" {
    description = "The name of the Key Vault"
    type        = string    
  
}

variable "resource_group_location" {    
    description = "value for the location of the resource group where the Key Vault will be created"
    type = string
  
}
variable "resource_group_name" {
    description = "The name of the resource group where the Key Vault will be created"
    type        = string
  
}

variable "sku_name" {
    description = "The SKU name for the Key Vault"
    type        = string
     
  
}

variable "purge_protection_enabled" {
      description = "Whether purge protection is enabled for the Key Vault"
        type        = bool
        
    }      