variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created"
  type        = string

}

variable "resource_group_location" {
  description = "The location of the resource group where the Key Vault will be created"
  type        = string
}
variable "key_vault_name" {
  description = "The name of the Key Vault"
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

variable "virtual_network_name" {
  description = "The name of the virtual network to be created"
  type        = string
  default     = "value"
}
variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["value"]
}

variable "frontend_subnet_name" {
  description = "The name of the subnet to be created"
  type        = string
}
variable "frontend_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "backend_subnet_name" {
  description = "The name of the subnet to be created"
  type        = string
}
variable "backend_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "frontend_pip_name" {
  description = "The name of the Public IP"
  type        = string
}

variable "backend_pip_name" {
  description = "The name of the Public IP"
  type        = string
}
variable "allocation_method" {
  description = "The allocation method for the Public IP (Static or Dynamic)"
  type        = string
  default     = "Static"

}
variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string

}

variable "frontend_vm_name" {
  description = "The name of the frontend virtual machine"
  type        = string
}
variable "backend_vm_name" {
  description = "The name of the backend virtual machine"
  type        = string
}

variable "frontend_nic_name" {
  description = "The name of the frontend virtual machine"
  type        = string
}
variable "backend_nic_name" {
  description = "The name of the backend virtual machine"
  type        = string
}

variable "frontend_nsg_name" {
  description = "The name of the frontend virtual machine"
  type        = string
}
variable "backend_nsg_name" {
  description = "The name of the backend virtual machine"
  type        = string
}

variable "user_name" {
  type = string
  
}
variable "user_name_value" {
  description = "The value of the secret"
  type        = string
  
}
variable "user_pwd" {
  type = string
  
}
variable "user_pwd_value" {
  description = "The value of the secret"
  type        = string
  
}
variable "nsg_rules" {
  description = "The network security group rules to be applied to the virtual machine."
  type       = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = optional(string, "")
  }))
  
    
}