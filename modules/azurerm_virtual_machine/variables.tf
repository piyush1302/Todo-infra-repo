variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
  
}
 variable "custom_data" {
  description = "The path to the script that will be executed on the virtual machine."
  type        = string
 }
  
  

variable "resource_group_name" {
  description = "The name of the resource group where the virtual machine will be created."
 
  type        = string  
}
variable "resource_group_location" {
  description = "The location of the resource group where the virtual machine will be created."
  type        = string

}
variable "vm_size" {
  description = "The size of the virtual machine."
  
  type        = string
}
# variable "admin_username" {
#   description = "The administrator username for the virtual machine."
# }
# variable "admin_password" {
#   description = "The administrator password for the virtual machine."
#   sensitive   = true
# }

variable "nic_name" {
  description = "The name of the network interface card (NIC) for the virtual machine."
  type        = string  
}


variable "subnet_name" {
  description = "The name of the virtual machine."
  type        = string  
}
variable "virtual_network_name" {
  description = "The name of the resource group where the virtual machine will be created."
  type        = string
}

variable "public_ip_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}
variable "user_name" {
  type = string
  
}
variable "user_pwd" {
  type = string
  
}