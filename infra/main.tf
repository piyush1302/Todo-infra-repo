module "rg" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location

}

module "keyvault" {
  depends_on               = [module.rg]
  source                   = "../modules/azurerm_key_vault"
  key_vault_name           = var.key_vault_name
  resource_group_name      = var.resource_group_name
  resource_group_location  = var.resource_group_location
  sku_name                 = var.sku_name
  purge_protection_enabled = var.purge_protection_enabled

}


# This module creates an Azure Key Vault and assigns a role to a user for managing secrets.
# The Key Vault is used to store sensitive information such as usernames and passwords.     

module "keyvault-secret_username" {
  depends_on   = [module.keyvault]
  source       = "../modules/azurerm_keyVault_secret"
  secret_name  = var.user_name
  secret_value = var.user_name_value
  key_vault_name = var.key_vault_name
  resource_group_name = var.resource_group_name

}

module "keyvault-secret_password" {
  depends_on   = [module.keyvault]
  source       = "../modules/azurerm_keyVault_secret"
 secret_name  = var.user_pwd
  secret_value = var.user_pwd_value
  key_vault_name = var.key_vault_name
  resource_group_name = var.resource_group_name
}


module "vnet" {
  depends_on              = [module.rg]
  source                  = "../modules/azurerm_virtual_network"
  virtual_network_name    = var.virtual_network_name
  address_space           = var.address_space
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location

}

module "frontend-subnet" {
  depends_on = [module.vnet]
  source     = "../modules/azurerm_subnet"
  # subnet_name          = "frontend-subnet-piyush-01"
  subnet_name         = var.frontend_subnet_name
  resource_group_name = var.resource_group_name

  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.frontend_address_prefixes
  # address_prefixes     = ["10.0.1.0/24"]


}
module "backend-subnet" {
  depends_on  = [module.vnet]
  source      = "../modules/azurerm_subnet"
  subnet_name = var.backend_subnet_name

  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.backend_address_prefixes


}

module "frontend-pip" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_public_ip"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  public_ip_name          = var.frontend_pip_name
  allocation_method       = var.allocation_method
}

module "backend-pip" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_public_ip"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  public_ip_name          = var.backend_pip_name
  allocation_method       = var.allocation_method

}

output "Backend-pip_address" {
  value = module.backend-pip.pip_id

}

output "frontend-pip_address" {
  value = module.frontend-pip.pip_id

}
module "frontend-vm" {
  depends_on = [module.frontend-subnet, module.frontend-pip, module.keyvault-secret_password, module.keyvault-secret_username]
  source     = "../modules/azurerm_virtual_machine"
  vm_name                 = var.frontend_vm_name
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  vm_size = var.vm_size
  nic_name             = var.frontend_nic_name
  virtual_network_name = var.virtual_network_name
  subnet_name          = var.frontend_subnet_name
  public_ip_name       = var.frontend_pip_name
   user_name = var.user_name
  user_pwd = var.user_pwd
  key_vault_name = var.key_vault_name
  
  custom_data = base64encode(<<-EOF
                #!/bin/bash
                sudo su
                apt update
                apt install -y nginx
                systemctl enable nginx
                systemctl start nginx
                apt install git-all
                curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
                apt install -y nodejs
                git clone https://github.com/piyush1302/Ppr-todo-frontend.git
                cd /Ppr-todo-frontend
                sudo su
                npm install
                npm run build
                cp -r build/* /var/www/html
                rm /var/www/html/index.nginx-debian.html


                EOF
  )
}



module "backend-vm" {
  depends_on = [module.backend-subnet, module.backend-pip, module.keyvault-secret_password, module.keyvault-secret_password]
  source     = "../modules/azurerm_virtual_machine"
  vm_name                 = var.backend_vm_name
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  vm_size                 = var.vm_size
  public_ip_name       = var.backend_pip_name
  nic_name             = var.backend_nic_name
  virtual_network_name = var.virtual_network_name
  subnet_name          = var.backend_subnet_name
  user_name = var.user_name
  user_pwd = var.user_pwd
  key_vault_name = var.key_vault_name
  custom_data = base64encode(<<-EOF
                #!/bin/bash
                sudo su
                apt-get update && apt-get install -y unixodbc unixodbc-dev
                curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
                curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
                apt-get update
                ACCEPT_EULA=Y apt-get install -y msodbcsql17
                apt install -y python3-pip
                apt install git-all
                git clone https://github.com/piyush1302/Ppr-todo-backend.git 
                cd /Ppr-todo-backend
                pip install -r requirements.txt
                # 
                uvicorn app:app --host 0.0.0.0 --port 8000
                EOF
  )
}


module "sql" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_sql"
  resource_group_location = var.resource_group_location
  resource_group_name     = var.resource_group_name

}

module "frontend-nsg" {
  depends_on = [module.frontend-vm, module.backend-vm]
  source     = "../modules/azurerm_nsg"
  nsg_name                = var.frontend_nsg_name
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  nsg_rules = var.nsg_rules 
  virtual_network_name = var.virtual_network_name
  subnet_name = var.frontend_subnet_name
   
  
}

module "backend-nsg" {
  depends_on = [module.frontend-vm, module.backend-vm]
  source     = "../modules/azurerm_nsg"
  nsg_name                = var.backend_nsg_name
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  nsg_rules = var.nsg_rules 
  virtual_network_name = var.virtual_network_name
  subnet_name = var.backend_subnet_name
  
}