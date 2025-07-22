terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
     
      version = "4.37.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "ApnaRG"
  #   storage_account_name = "pprstg01"
  #   container_name       = "pprtfstate"
  #   key                  = "devstate"
    
  # }
#   backend "local" {}
#   required_version = ">= 1.5.0"
 }

provider "azurerm" {
  features {}
  subscription_id = "9f2fc162-8625-4e93-8616-a608f22e0f7e"

}