terraform {
    required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "resource_group_name" {
    type    = string
    default = "strapi-rg"
}

variable "location" {
    type = string
    default = "South India"
}

variable "vm_size" {
    type    = string
    default = Standard_D2s_v3
}

variable "admin_username" {
    type    = string
    default = "azureuser"
}

variable "admin_password" {
    type        = string
}

variable "storage_account_name" {
    type    = string
    default = "strapibackendstorage"
}

variable "cosmos_db_account_name" {
    type    = string
    default = "strapicosmosdb"
}

resource "azurerm_resource_group" "strapi_rg" {
    name       = var.resource_group_name
    location    = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "strapiVnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "internal-subnet" {
  name                 = "strapiSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "strapiNIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "strapiNICConfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}