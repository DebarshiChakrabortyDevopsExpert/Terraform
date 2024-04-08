resource "azurerm_mssql_server_security_alert_policy" "securityalert" {
  for_each                   = var.ms_sql_security_alert_policy  
  resource_group_name        = each.value.resource_group_name
  server_name                = azurerm_mssql_server.mssqlserver.name
  state                      = try(each.value.state,"Enabled")
  storage_endpoint           = data.azurerm_storage_account.securityalert[each.key].primary_blob_endpoint
  storage_account_access_key = data.azurerm_storage_account.securityalert[each.key].primary_access_key  
  email_account_admins       = try(each.value.email_account_admins,false)
  email_addresses            = try(each.value.email_addresses,null)
  disabled_alerts            = try(each.value.disabled_alerts,null)
  retention_days             = try(each.value.retention_days,null)
}