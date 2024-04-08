resource "azurerm_windows_web_app_slot" "windows_web_app" {
  for_each                   = var.webapp_slot
  name                       = each.value.web_app_slotname
  app_service_id             = azurerm_windows_web_app.windows_web_app.id
  https_only                 = try(each.value["https_only"], true)
  app_settings               = merge({ "APPINSIGHTS_INSTRUMENTATIONKEY" = data.azurerm_application_insights.exiting_application_insights.instrumentation_key }, try(each.value.app_settings, null))
  client_certificate_enabled = try(each.value["client_certificate_enabled"], null)
  client_certificate_mode    = try(each.value["client_certificate_mode"], null)
  tags                       = try(each.value.tags, null)

  dynamic "identity" {
    for_each = try(each.value.identity, null) != null ? [each.value.identity] : []
    content {
      type         = try(identity.value.type, "SystemAssigned")
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "site_config" {
    for_each = try(each.value.site_config, null) != null ? [each.value.site_config] : []

    content {
      always_on                = try(site_config.value.always_on, false)
      worker_count             = try(site_config.value.worker_count, 1)
      app_command_line         = try(site_config.value.app_command_line, null)
      default_documents        = try(site_config.value.default_documents, null)
      ftps_state               = try(site_config.value.ftps_state, "FtpsOnly")
      health_check_path        = try(site_config.value.health_check_path, null)
      http2_enabled            = try(site_config.value.http2_enabled, false)
      managed_pipeline_mode    = try(site_config.value.managed_pipeline_mode, null)
      minimum_tls_version      = try(site_config.value.minimum_tls_version, "1.2")
      remote_debugging_enabled = try(site_config.value.remote_debugging_enabled, false)
      remote_debugging_version = try(site_config.value.remote_debugging_version, null)
      websockets_enabled       = try(site_config.value.websockets_enabled, false)

      dynamic "application_stack" {
        for_each = try(site_config.value.application_stack, null) != null ? [site_config.value.application_stack] : []

        content {
          current_stack  = try(application_stack.value.current_stack, "node")
          dotnet_version = try(application_stack.value.dotnet_version, null)
          node_version   = try(application_stack.value.dotnet_version, "16-LTS")
        }

      }

      dynamic "virtual_application" {
        for_each = try(site_config.value.virtual_application, null) != null ? [site_config.value.virtual_application] : []

        content {
          physical_path = try(virtual_application.value.physical_path, "site\\wwwroot")
          preload       = try(virtual_application.value.preload, false)
          virtual_path  = try(virtual_application.value.virtual_path, "/")
        }
      }

      dynamic "ip_restriction" {
        for_each = try(site_config.value.ip_restriction, null) != null ? [site_config.value.ip_restriction] : []
        content {
          ip_address                = try(ip_restriction.value.ip_address, null)
          service_tag               = try(ip_restriction.value.service_tag, null)
          name                      = try(ip_restriction.value.name, null)
          priority                  = try(ip_restriction.value.priority, null)
          action                    = try(ip_restriction.value.action, null)
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
    for_each = try(each.value.connection_string, null) != null ? [each.value.connection_string] : []

    content {
      name  = try(connection_string.value.name, null)
      type  = try(connection_string.value.type, null)
      value = try(connection_string.value.value, null)
    }
  }

  dynamic "auth_settings" {
    for_each = try(each.value.auth_settings, null) != null ? [each.value.auth_settings] : []

    content {
      enabled                        = try(auth_settings.value.enabled, false)
      additional_login_parameters    = try(auth_settings.value.additional_login_parameters, null)
      allowed_external_redirect_urls = try(auth_settings.value.allowed_external_redirect_urls, null)
      default_provider               = try(auth_settings.value.default_provider, null)
      issuer                         = try(auth_settings.value.issuer, null)
      runtime_version                = try(auth_settings.value.runtime_version, null)
      token_refresh_extension_hours  = try(auth_settings.value.token_refresh_extension_hours, null)
      token_store_enabled            = try(auth_settings.value.token_store_enabled, null)
      unauthenticated_client_action  = try(auth_settings.value.unauthenticated_client_action, null)

      dynamic "github" {
        for_each = try(auth_settings.value.github, null) != null ? [auth_settings.value.github] : []

        content {
          client_id                  = try(github.value.client_id, null)
          client_secret              = try(github.value.client_secret, null)
          client_secret_setting_name = try(github.value.client_secret_setting_name, null)
          oauth_scopes               = try(github.value.oauth_scopes, null)
        }
      }
    }
  }
}