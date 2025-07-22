resource "azurerm_mssql_server" "sql_server" {
  name                         = "piyush-sql-server"
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location

  version                      = "12.0"
  administrator_login          = "piyushadmin"
  administrator_login_password = "Piyush@1234"

  public_network_access_enabled = true
   
}

resource "azurerm_mssql_database" "sql_database" {
  name                = "piyush-sql-database"
  server_id           = azurerm_mssql_server.sql_server.id
  sku_name            = "S0"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb = 1
  enclave_type = "VBS"

 
}

resource "azurerm_mssql_firewall_rule" "sql_firewall_rule" {
  name                = "piyush_sql_firewall_rule"
  server_id = azurerm_mssql_server.sql_server.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
  
}
