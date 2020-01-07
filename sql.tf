resource "random_id" "randomId" {
  byte_length = 4
}

resource "azurerm_resource_group" "sql" {
  name     = "${azurerm_resource_group.rgmain.name}-sql"
  location = "${azurerm_resource_group.rgmain.location}"
}


resource "azurerm_sql_server" "instance" {
  name                         = "${var.sql_svr_name_prefix}${random_id.randomId.hex}"
  resource_group_name          = "${azurerm_resource_group.sql.name}"
  location                     = "${azurerm_resource_group.sql.location}"
  version                      = "${var.sql_svr_ver}"
  administrator_login          = "${var.sql_admin_user}"
  administrator_login_password = "${var.sql_admin_pwd}"
}

resource "azurerm_sql_database" "dbinstance" {
  name                             = "sqldbinstance"
  resource_group_name              = "${azurerm_resource_group.rgmain.name}-sql"
  location                         = "${azurerm_resource_group.rgmain.location}"
  server_name                      = "${azurerm_sql_server.instance.name}"
  edition                          = "${var.sql_db_edition}"
  requested_service_objective_name = "${var.sql_db_service_objective_name}"

  tags = {
    environment = "lab"
  }
}