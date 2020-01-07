module "network" {
  source              = "Azure/network/azurerm"
  version             = "~> 1.1.1"
  location            = "${azurerm_resource_group.rgmain.location}"
  allow_rdp_traffic   = "true"
  allow_ssh_traffic   = "true"
  resource_group_name = "${azurerm_resource_group.rgmain.name}-network"
  subnet_prefixes     = "${var.net_sub_cidr}"
  subnet_names        = "${var.net_sub_name}"
}

resource "azurerm_subnet" "private_link_endpoint" {
  name                                           = "endpointsubnet"
  virtual_network_name                           = "${module.network.vnet_name}"
  resource_group_name                            = "${azurerm_resource_group.rgmain.name}-network"
  address_prefix                                 = "${var.net_endpoint_sub_cidr}"
  network_security_group_id                      = "${module.network.security_group_id}"
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_private_endpoint" "plink" {
  name                = "sql_endpoint"
  location            = "${azurerm_resource_group.rgmain.location}"
  resource_group_name = "${azurerm_subnet.private_link_endpoint.resource_group_name}"
  subnet_id           = "${azurerm_subnet.private_link_endpoint.id}"

  private_service_connection {

    name                           = "sqlprivatelink"
    is_manual_connection           = "false"
    private_connection_resource_id = "${azurerm_sql_server.instance.id}"
    subresource_names              = ["sqlServer"]
  }
}

resource "azurerm_private_dns_zone" "plink_dns_private_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = "${azurerm_subnet.private_link_endpoint.resource_group_name}"
}


data "azurerm_private_endpoint_connection" "plinkconnection" {
  name                = "${azurerm_private_endpoint.plink.name}"
  resource_group_name = "${azurerm_private_endpoint.plink.resource_group_name}"
}

resource "azurerm_private_dns_a_record" "private_endpoint_a_record" {
  name                = "${azurerm_sql_server.instance.name}"
  zone_name           = "${azurerm_private_dns_zone.plink_dns_private_zone.name}"
  resource_group_name = "${azurerm_private_endpoint.plink.resource_group_name}"
  ttl                 = 300
  records             = ["${data.azurerm_private_endpoint_connection.plinkconnection.private_service_connection.0.private_ip_address}"]
}

resource "azurerm_private_dns_zone_virtual_network_link" "zone_to_vnet_link" {
  name                  = "test"
  resource_group_name   = "${azurerm_private_endpoint.plink.resource_group_name}"
  private_dns_zone_name = "${azurerm_private_dns_zone.plink_dns_private_zone.name}"
  virtual_network_id    = "${module.network.vnet_id}"
}

output "private_link_endpoint_ip" {
  value = "${data.azurerm_private_endpoint_connection.plinkconnection.private_service_connection.0.private_ip_address}"
}