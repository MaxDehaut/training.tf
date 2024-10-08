
resource "random_pet" "login" {
  length = 3
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@/'\""
}

# SQL Server
resource "azurerm_mssql_server" "training" {
  name                         = "sql-${var.suffix}"
  resource_group_name          = var.rg.name
  location                     = var.rg.location
  version                      = "12.0"
  administrator_login          = random_pet.login.id
  administrator_login_password = random_password.password.result
}
