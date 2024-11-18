resource "azurerm_storage_account" "storage_account" {
    name                        = var.storage_account
    resource_group_name         = var.rgname
    location                    = var.rglocation 
    account_tier                = "Standard" 
    account_replication_type    = "LRS" 
    is_hns_enabled              = false 
}

resource "azurerm_storage_container" "container" {
    name                        = var.container
    storage_account_name        = var.storage_account
    container_access_type       = "private" 
}
resource "null_resource" "storage_details" {
    provisioner "local-exec" {
        command = <<EOF
          echo '{
            "storage_account_name": "${azurerm_storage_account.storage_account.name}",
            "storage_account_key": "${azurerm_storage_account.storage_account.primary_access_key}",
            "blob_container_name": "${azurerm_storage_container.container.name}",
            "storage_account_region": "${azurerm_resource_group.rg.location}"
          }' > ./output/storage-details.json
        EOF
    }
}
