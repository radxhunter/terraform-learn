terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=3.95.0"
        }
    }
    
    backend "azurerm" {
      resource_group_name = "radeks-state"      
      storage_account_name = "radekstfstate"      
      container_name = "tstate"      
      key = "terraform.tfstate"      
    }
} 

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rgFromTerraform" {
  name = "radeks-rg"
  location = "UK South"
}

resource "azurerm_virtual_network" "vnetFromTerraform" {
  name = "radeks-vnet"
  resource_group_name = azurerm_resource_group.rgFromTerraform.name
  location = azurerm_resource_group.rgFromTerraform.location
  address_space = [ "10.0.0.0/16" ]
}

resource "azurerm_subnet" "subnetFromTerraform" {
  name = "radeks-subnet"
  resource_group_name = azurerm_resource_group.rgFromTerraform.name
  virtual_network_name = azurerm_virtual_network.vnetFromTerraform.name
  address_prefixes = [ "10.0.2.0/24" ]
}