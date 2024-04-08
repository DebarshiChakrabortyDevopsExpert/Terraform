resource "azurerm_mssql_firewall_rule" "firewall_rules" {
  for_each         = var.ms_sql_server_firewall_rule
  name             = "sqlfw-org-${each.value.env}-uks-${each.value.instance_number}"
  server_id        = azurerm_mssql_server.mssqlserver.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}