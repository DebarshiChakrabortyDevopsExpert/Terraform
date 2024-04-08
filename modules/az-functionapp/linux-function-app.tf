resource "azurerm_linux_function_app" "linux_function_app" {
  name                       = "fa-org-${var.linux_function_app.env}-uks-${var.linux_function_app.instance_number}"
  resource_group_name        = var.linux_function_app.resource_group_name
  location                   = var.linux_function_app.location
  storage_account_name       = var.linux_function_app.storage_account_name
  app_settings               = merge({ "APPINSIGHTS_INSTRUMENTATIONKEY" = data.azurerm_application_insights.exiting_application_insights.instrumentation_key }, try(var.linux_function_app.app_settings, null))
  storage_account_access_key = data.azurerm_storage_account.storage_account.primary_access_key
  service_plan_id            = data.azurerm_service_plan.service_plan.id
  builtin_logging_enabled    = try(var.linux_function_app.builtin_logging_enabled, "false")
  enabled                    = try(var.linux_function_app.enabled, null)
  https_only                 = try(var.linux_function_app.https_only, null)
  virtual_network_subnet_id  = try(var.linux_function_app.virtual_network_subnet_id, null)
  tags                       = try(var.linux_function_app.tags, null)

  dynamic "identity" {
    for_each = try(var.linux_function_app.identity, null) != null ? [var.linux_function_app.identity] : []
    content {
      type         = try(identity.value.type, "SystemAssigned")
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "site_config" {
    for_each = try(var.linux_function_app.site_config, null) != null ? [var.linux_function_app.site_config] : []

    content {
      always_on                              = try(site_config.value.always_on, false)
      api_definition_url                     = try(site_config.value.api_definition_url, null)
      api_management_api_id                  = try(site_config.value.api_management_api_id, null)
      app_command_line                       = try(site_config.value.app_command_line, null)
      app_scale_limit                        = try(site_config.value.app_scale_limit, null)
      application_insights_connection_string = try(site_config.value.application_insights_connection_string, null)
      application_insights_key               = try(site_config.value.application_insights_key, null)
      minimum_tls_version                    = try(site_config.value.minimum_tls_version, "1.2")
      default_documents                      = try(site_config.value.default_documents, null)
      ftps_state                             = try(site_config.value.ftps_state, "FtpsOnly")
      http2_enabled                          = try(site_config.value.http2_enabled, false)
      load_balancing_mode                    = try(site_config.value.load_balancing_mode, "LeastRequests")
      vnet_route_all_enabled                 = try(site_config.value.vnet_route_all_enabled, true)
      worker_count                           = try(site_config.value.worker_count, 1)

      dynamic "application_stack" {
        for_each = try(site_config.value.application_stack, null) != null ? [site_config.value.application_stack] : []
        content {
          node_version = try(application_stack.value.node_version, "16")
        }
      }

      dynamic "ip_restriction" {
        for_each = try(site_config.value.ip_restriction, null) != null ? [site_config.value.ip_restriction] : []
        content {
          ip_address  = try(ip_restriction.value.ip_address, null)
          service_tag = try(ip_restriction.value.service_tag, null)
          name        = try(ip_restriction.value.name, null)
          priority    = try(ip_restriction.value.priority, null)
          action      = try(ip_restriction.value.action, null)
          dynamic "headers" {
            for_each = try(ip_restriction.value.headers, null) != null ? [ip_restriction.value.headers] : []
            content {
              x_azure_fdid      = try(headers.value.x_azure_fdid, null)
              x_fd_health_probe = try(headers.value.x_fd_health_probe, null)
              x_forwarded_for   = try(headers.value.x_forwarded_for, null)
              x_forwarded_host  = try(headers.value.x_forwarded_host, null)
            }
          }
        }
      }
    }
  }


  dynamic "connection_string" {
    for_each = try(var.linux_function_app.connection_string, null) != null ? [var.linux_function_app.connection_string] : []
    content {
      name  = try(connection_string.value.name, null)
      type  = try(connection_string.value.type, null)
      value = try(connection_string.value.value, null)
    }
  }

  lifecycle {
    ignore_changes        = [
      virtual_network_subnet_id
    ]
  }

}
