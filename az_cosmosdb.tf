resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.rglocation
}

resource "azurerm_network_security_group" "cosmos_sg" {
  name                     = "cosmos_security_group"
  location                 = var.rglocation
  resource_group_name      = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-CosmosDB-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"  # Default Cosmos DB port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-All-Outbound"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name = "Cosmos_Security_Group"
  }
}

resource "azurerm_cosmosdb_account" "strapi_cdb" {
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
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.strapi_cdb.name
}

resource "azurerm_cosmosdb_sql_container" "strapi_cosmos_db_container" {
  name                  = var.sqlcontainer
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.strapi_cdb.name
  database_name         = azurerm_cosmosdb_sql_database.strapi_cosmos_db_database.name
  partition_key_paths   = ["/definition/id"]
  partition_key_version = 1
  throughput            = 400
}

resource "azurerm_subnet" "subnetA" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = var.vnet
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "sec-group-association" {
  subnet_id                 = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.cosmos_sg.id
}
