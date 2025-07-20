data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "akv" {
    name                        = var.key_vault_name
    location                    = var.resource_group_location
    resource_group_name         = var.resource_group_name
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    sku_name                    = var.sku_name
    enable_rbac_authorization = true
    purge_protection_enabled = var.purge_protection_enabled
    
  
}

resource "azurerm_role_assignment" "akv_role_assignment" {
    scope                = azurerm_key_vault.akv.id
    role_definition_name = "Key Vault administrator"
    principal_id = data.azurerm_client_config.current.object_id
  
}

