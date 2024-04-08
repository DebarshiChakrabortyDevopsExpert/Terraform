resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  for_each                       = var.webapp_diagnostics_settings
  name                           = each.value.name
  target_resource_id             = azurerm_windows_web_app.windows_web_app.id
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