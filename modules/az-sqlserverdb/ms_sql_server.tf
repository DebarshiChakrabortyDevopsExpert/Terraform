resource "azurerm_mssql_server" "mssqlserver" {
  name                = "sqldb-org-${var.ms_sql_server.env}-eus-${var.ms_sql_server.instance_number}"
  resource_group_name = var.ms_sql_server.resource_group_name
  location            = var.ms_sql_server.location
  version             = try(var.ms_sql_server.version, "12.0")

  ## if administrator_login is supplied then azuread_administrator should not be supplied

  administrator_login                  = try(data.azurerm_key_vault_secret.keyvault_sql_admin_name.value, null)
  administrator_login_password         = try(data.azurerm_key_vault_secret.keyvault_sql_sercret_name.value, null)
  public_network_access_enabled        = try(var.ms_sql_server.public_network_access_enabled, false)
  outbound_network_restriction_enabled = try(var.ms_sql_server.outbound_network_restriction_enabled, false)
  connection_policy                    = try(var.ms_sql_server.connection_policy, "Default")
  minimum_tls_version                  = try(var.ms_sql_server.minimum_tls_version, "1.2")
  tags                                 = try(var.ms_sql_server.tags, null)

  ## if azuread_authentication_only is true then administrator_login and administrator_login_password
  ## Should be ignored

  dynamic "azuread_administrator" {
    for_each = try(var.ms_sql_server.azuread_administrator, null) != null ? [var.ms_sql_server.azuread_administrator] : []
    content {
      login_username              = try(azuread_administrator.value.login_username, null)
      object_id                   = try(azuread_administrator.value.object_id, null)
      tenant_id                   = try(azuread_administrator.value.tenant_id, null)
      azuread_authentication_only = try(azuread_administrator.value.azuread_authentication_only, null)
    }
  }

  dynamic "identity" {
    for_each = try(var.ms_sql_server.identity, null) != null ? [var.ms_sql_server.identity] : []
    content {
      type         = try(identity.value.type, "SystemAssigned")
      identity_ids = try(identity.value.identity_ids, null)
    }
  }
}