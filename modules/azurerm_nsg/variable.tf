variable "resource_group_location" {    
    description = "value for the location of the resource group where the Key Vault will be created"
    type = string
  
}
variable "resource_group_name" {
    description = "The name of the resource group where the Key Vault will be created"
    type        = string
  
}

variable "nsg_name" {
  description = "The name of the network security group."
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

variable "subnet_name" {
    description = "The name of the subnet to be created"
    type        = string    
}

   
variable "virtual_network_name" {
    description = "The name of the virtual network where the subnet will be created"
    type        = string    
}