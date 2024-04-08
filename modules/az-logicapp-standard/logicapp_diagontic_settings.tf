resource "azurerm_monitor_diagnostic_setting" "loggic_std_diagnostics" {
  for_each                       = var.logicapp_std_diagnostics_settings
  name                           = each.value.name
  target_resource_id             = azurerm_logic_app_standard.logic_app_standard.id
  log_analytics_workspace_id     = try(each.value.log_analytics_workspace_id, null)
  log_analytics_destination_type = try(each.value.log_analytics_destination_type, null)

  dynamic "log" {
    for_each = try(each.value.log, [])
    content {
      category       = try(log.value.category, null)
      category_group = try(log.value.category_group, null)
      enabled        = try(log.value.enabled, false)
    }
  }

  dynamic "metric" {
    for_each = try(each.value.metric, [])
    content {
      category = try(metric.value.category, null)
      enabled  = try(metric.value.enabled, false)
    }
  }
  lifecycle {
    ignore_changes        = [
      log_analytics_destination_type,
      log
    ]
  }
}