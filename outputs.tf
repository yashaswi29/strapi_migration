# output "instance_details" {
#     value = {
#         instance_id = azurerm_linux_virtual_machine.vm.id
#         public_ip   = azurerm_network_interface.net-int.private_ip_address
#         private_ip  = azurerm_network_interface.net-int.private_ip_address
#     }
# }

# output "azure_cosmosdb_details" {
#     value = {
#         cosmosdb_name   = azurerm_cosmosdb_account.strapi-cdb.name
#         cosmosdb_region = azurerm_cosmosdb_account.strapi-cdb.geo_location[0].location
#         cosmosdb_endpoint = azurerm_cosmosdb_account.strapi-cdb.endpoint
#         cosmosdb_key    = azurerm_cosmosdb_account.strapi-cdb.primary_master_key
#         cosmosdb_database = azurerm_cosmosdb_sql_database.strapi_cosmos_db_database.name
#         cosmosdb_container = azurerm_cosmosdb_sql_container.strapi_cosmos_db_container.name
#     }
# }

# output "azure_storage_account_details" {
#     value = {
#         storage_account_name  = azurerm_storage_account.storage_account.name
#         storage_account_arn   = azurerm_storage_account.storage_account.id
#         storage_account_region = azurerm_storage_account.storage_account.location
#     }
# }