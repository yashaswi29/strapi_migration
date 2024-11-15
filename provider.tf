terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.10.0"
    }
  }
}
provider "azurerm" {
  subscription_id = "e4f118d5-770b-4a41-b2ab-1d30604708f1"
  features {}
}