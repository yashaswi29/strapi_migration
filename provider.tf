terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.10.0"
    }
  }
}
provider "azurerm" {
  subscription_id = "845af220-bace-45d4-9979-ed5993293ae3"
  features {}
}