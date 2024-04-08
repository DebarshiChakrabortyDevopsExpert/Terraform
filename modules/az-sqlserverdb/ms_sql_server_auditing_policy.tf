resource "azurerm_mssql_server_extended_auditing_policy" "auditing" {
  for_each                                = var.ms_sql_server_auditing_policy
  server_id                               = azurerm_mssql_server.mssqlserver.id
  enabled                                 = try(each.value.enabled, true)
#  storage_account_access_key              = try(data.azurerm_storage_account.extended_auditing_policy[each.key].primary_access_key, null)
  storage_endpoint                        = try(data.azurerm_storage_account.extended_auditing_policy[each.key].primary_blob_endpoint, null)
  storage_account_access_key_is_secondary = try(each.value.storage_account_access_key_is_secondary, false)
  retention_in_days                       = try(each.value.retention_in_days, 6)
  log_monitoring_enabled                  = try(each.value.log_monitoring_enabled, true)
  depends_on                              = [azurerm_role_assignment.sql_blob_data_contributor]
}

resource "azurerm_role_assignment" "sql_blob_data_contributor" {
  for_each             = var.ms_sql_server_auditing_policy
  scope                = data.azurerm_storage_account.extended_auditing_policy[each.key].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_mssql_server.mssqlserver.identity.0.principal_id
}