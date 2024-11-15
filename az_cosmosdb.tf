  resource "azurerm_resource_group" "rg" {
    name     = var.rgname
    location = var.rglocation
  }

  resource "azurerm_cosmosdb_account" "strapi-cdb" {
    name                      = var.cosmosdbaccountname
    location                  = var.rglocation
    resource_group_name       = azurerm_resource_group.rg.name
    offer_type                = "Standard"
    kind                      = "GlobalDocumentDB"
    geo_location {
      location          = var.rglocation
      failover_priority = 0
    }
    consistency_policy {
      consistency_level       = "Session"
    }
    #   capabilities {
    #   name = "EnablePostgres"  
    # }
    depends_on = [
      azurerm_resource_group.rg
    ]
  }


resource "azurerm_cosmosdb_postgresql_cluster" "postgres-cdb" {
  name                            = "examplecluster"
  resource_group_name             = azurerm_resource_group.example.name
  location                        = azurerm_resource_group.example.location
  administrator_login_password    = "H@Sh1CoR3!"
  coordinator_storage_quota_in_mb = 131072
  coordinator_vcore_count         = 2
  node_count                      = 2
  node_storage_quota_in_mb        = 131072
  node_vcores                     = 2
}

resource "azurerm_cosmosdb_postgresql_coordinator_configuration" "example" {
  name       = "array_nulls"
  cluster_id = azurerm_cosmosdb_postgresql_cluster.example.id
  value      = "on"
}