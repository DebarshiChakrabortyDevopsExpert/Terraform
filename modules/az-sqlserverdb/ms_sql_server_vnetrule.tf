resource "azurerm_mssql_virtual_network_rule" "network_rules" {
  for_each  = var.ms_sql_server_vnet_rule
  name      = each.value.name
  server_id = azurerm_mssql_server.mssqlserver.id
  subnet_id = data.azurerm_subnet.subnet[each.key].id
}