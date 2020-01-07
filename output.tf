output "Windows_server_DNS_name" {
  value = "${module.windowsservers.public_ip_dns_name}"
}
output "Windows_SQL_Server_name" {
  value = "${azurerm_sql_server.instance.fully_qualified_domain_name}"
}