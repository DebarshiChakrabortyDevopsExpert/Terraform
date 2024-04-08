resource "azurerm_logic_app_standard" "logic_app_standard" {
  name                               = "lgapp-org-${var.logic_app_standard.env}-eus-${var.logic_app_standard.instance_number}"
  location                           = var.logic_app_standard.location
  resource_group_name                = var.logic_app_standard.resource_group_name
  app_service_plan_id                = data.azurerm_service_plan.logic_app_std.id
  storage_account_name               = var.logic_app_standard.storage_account_name
  app_settings                       = merge({ "APPINSIGHTS_INSTRUMENTATIONKEY" = data.azurerm_application_insights.exiting_application_insights.instrumentation_key }, try(var.logic_app_standard.app_settings, null))
  storage_account_access_key         = data.azurerm_storage_account.logic_app_std.primary_access_key
  enabled                            = try(var.logic_app_standard.enabled, true)
  client_affinity_enabled            = try(var.logic_app_standard.client_affinity_enabled, null)
  https_only                         = try(var.logic_app_standard.https_only, true)
  virtual_network_subnet_id          = try(var.logic_app_standard.virtual_network_subnet_id, null)
  tags                               = try(var.logic_app_standard.tags, null)

  dynamic "identity" {
    for_each = try(var.logic_app_standard.identity, null) != null ? [var.logic_app_standard.identity] : []
    content {
      type         = try(identity.value.type, "SystemAssigned")
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "site_config" {
    for_each = try(var.logic_app_standard.site_config, null) != null ? [var.logic_app_standard.site_config] : []

    content {
      always_on                              = try(site_config.value.always_on, false)
      dotnet_framework_version               = try(site_config.value.dotnet_framework_version, null)
      health_check_path                      = try(site_config.value.health_check_path, null)
      ip_restriction                         = try(site_config.value.ip_restriction, [])
      ftps_state                             = try(site_config.value.ftps_state, "FtpsOnly")
      http2_enabled                          = try(site_config.value.http2_enabled, false)
      vnet_route_all_enabled                 = try(site_config.value.vnet_route_all_enabled, null)
      websockets_enabled                     = try(site_config.value.websockets_enabled, null)
    }
  }

  lifecycle {
    ignore_changes        = [
      virtual_network_subnet_id
    ]
  }

}
