data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
}

data "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "akv" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}
data "azurerm_key_vault_secret" "vm_username" {
  name               = var.user_name
  key_vault_id       = data.azurerm_key_vault.akv.id
}
data "azurerm_key_vault_secret" "vm_password" {
  name         = var.user_pwd
  key_vault_id = data.azurerm_key_vault.akv.id
}