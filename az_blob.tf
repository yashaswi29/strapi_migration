resource "azurerm_storage_account" "storage_account" {
    name                        = var.storage_account
    resource_group_name         = var.rgname
    location                    = var.rglocation 
    account_tier                = "Standard" 
    account_replication_type    = "LRS" 
    is_hns_enabled              = false 
}

resource "azurerm_storage_container" "container" {
    name                    = var.container
    storage_account_name     = var.storage_account
    container_access_type   = "private" 
}

