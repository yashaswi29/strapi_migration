  resource "azurerm_resource_group" "rg" {
    name                      = var.rgname
    location                  = var.rglocation
  }

  resource "azurerm_cosmosdb_account" "strapi-cdb" {
    name                      = var.cosmosdbaccount
    location                  = var.rglocation
    resource_group_name       = azurerm_resource_group.rg.name
    offer_type                = "Standard"
    kind                      = "GlobalDocumentDB"
    geo_location {
      location                = var.rglocation
      failover_priority       = 0
    }
    consistency_policy {
      consistency_level       = "Session"
    }
    depends_on = [
      azurerm_resource_group.rg
    ]
  }

resource "azurerm_cosmosdb_sql_database" "strapi_cosmos_db_database" {
    name                = var.cosmosdbdatabase
    resource_group_name = var.rgname
    account_name        = var.cosmosdbaccount
}

resource "azurerm_cosmosdb_sql_container" "strapi_cosmos_db_container" {
  name                  = var.sqlcontainer
  resource_group_name   = var.rgname
  account_name          = var.cosmosdbaccount
  database_name         = var.cosmosdbdatabase
  partition_key_paths   = ["/definition/id"]
  partition_key_version = 1
  throughput            = 400
}