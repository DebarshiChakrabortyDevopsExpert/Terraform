resource "azurerm_mssql_database" "mssql_database" {
  for_each                    = var.ms_sql_database
  name                        = each.value.name
  server_id                   = azurerm_mssql_server.mssqlserver.id
  max_size_gb                 = try(each.value.max_size_gb, 400)
  collation                   = try(each.value.collation, "SQL_Latin1_General_CP1_CI_AS")
  license_type                = try(each.value.license_type, null)
  create_mode                 = try(each.value.create_mode, "Default")
  sku_name                    = try(each.value.sku_name, "ElasticPool")
  read_scale                  = try(each.value.read_scale, false)
  zone_redundant              = try(each.value.zone_redundant, false)
  elastic_pool_id             = try(azurerm_mssql_elasticpool.mssql_elasticpool[each.value.key].id, null)
  geo_backup_enabled          = try(each.value.geo_backup_enabled, false)
  ledger_enabled              = try(each.value.ledger_enabled, false)
  auto_pause_delay_in_minutes = try(each.value.auto_pause_delay_in_minutes, -1)
  restore_point_in_time       = try(each.value.restore_point_in_time, null)
  recover_database_id         = try(each.value.recover_database_id, null)
  restore_dropped_database_id = try(each.value.restore_dropped_database_id, null)
  read_replica_count          = try(each.value.read_replica_count, 0)
  tags                        = try(each.value.tags, null)

  ## if storage account type is given then threat detection policy need to be enabled
  storage_account_type = try(each.value.storage_account_type, null)
  dynamic "threat_detection_policy" {
    for_each = lookup(each.value, "threat_detection_policy", {}) == {} ? [] : [1]
    content {
      state                      = each.value.threat_detection_policy.state
      disabled_alerts            = try(each.value.threat_detection_policy.disabled_alerts, null)
      email_account_admins       = try(each.value.threat_detection_policy.email_account_admins, null)
      email_addresses            = try(each.value.threat_detection_policy.email_addresses, null)
      retention_days             = try(each.value.threat_detection_policy.retention_days, null)
      #storage_account_access_key = try(data.azurerm_storage_account.threat_detection_policy_storage_account[each.key].primary_access_key, null)
      storage_endpoint           = try(data.azurerm_storage_account.threat_detection_policy_storage_account[each.key].primary_blob_endpoint, null)
    }
  }
}
