## subnet for enabling service enpoint for sql
data "azurerm_subnet" "subnet" {
  for_each             = var.ms_sql_server_vnet_rule
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.virtual_network_rgname
}

## keyvault for retriving the sql admin username and password
data "azurerm_key_vault" "keyvault" {
  name                = var.ms_sql_server.key_vault_name
  resource_group_name = var.ms_sql_server.key_vault_rg
}

data "azurerm_key_vault_secret" "keyvault_sql_sercret_name" {
  name         = var.ms_sql_server.sql_password_secret_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "keyvault_sql_admin_name" {
  name         = var.ms_sql_server.sql_admin_secret_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

## Storage account to enable threat detection policy for sql server
data "azurerm_storage_account" "threat_detection_policy_storage_account" {
  for_each            = var.ms_sql_database
  name                = each.value.threat_detection_storage_account_name
  resource_group_name = each.value.threat_detection_storage_account_rg_name
}

## Subnet and DNS zone for private endpoint
data "azurerm_subnet" "subnet_private_endpoint" {
  for_each             = var.ms_sql_server_pvt_endpnt
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_rg_name
}

## Server Audit
data "azurerm_storage_account" "extended_auditing_policy" {
  for_each            = var.ms_sql_server_auditing_policy
  name                = each.value.auditing_policy_storage_account_name
  resource_group_name = each.value.auditing_policy_storage_account_rg_name
}

## Server security alerts
data "azurerm_storage_account" "securityalert" {
  for_each            = var.ms_sql_security_alert_policy
  name                = each.value.security_policy_storage_account_name
  resource_group_name = each.value.security_policy_storage_account_rg_name
}
