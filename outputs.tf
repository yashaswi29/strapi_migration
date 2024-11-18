output "instance_details" {
  value = {
    vm_id       = azurerm_linux_virtual_machine.vm.id
    public_ip   = azurerm_public_ip.public_ip.ip_address
    private_ip  = azurerm_linux_virtual_machine.vm.private_ip_address
  }
}

output "azure_db_details" {
  value = {
    db_name         = azurerm_cosmosdb_sql_database.strapi_cosmos_db_database.name
    db_account_name = azurerm_cosmosdb_account.strapi-cdb.name
    db_hostname     = azurerm_cosmosdb_account.strapi-cdb.endpoint
    db_key          = azurerm_cosmosdb_account.strapi-cdb.primary_key
    db_container    = azurerm_cosmosdb_sql_container.strapi_cosmos_db_container.name
  }
  sensitive = true
}

output "azure_storage_details" {
  value = {
    storage_account_name   = azurerm_storage_account.storage_account.name
    storage_account_key    = azurerm_storage_account.storage_account.primary_access_key
    blob_container_name    = azurerm_storage_container.container.name
    storage_account_region = azurerm_resource_group.rg.location
  }
  sensitive = true
}
