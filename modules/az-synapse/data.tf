## Keyvault to retrive sql server password
data "azurerm_key_vault" "synapse_secret_keyvault" {
  name                = var.synapse_workspace.key_vault_name
  resource_group_name = var.synapse_workspace.key_vault_rg
}

data "azurerm_key_vault_secret" "synapse_admin" {
  name         = var.synapse_workspace.sql_secret_admin
  key_vault_id = data.azurerm_key_vault.synapse_secret_keyvault.id
}
data "azurerm_key_vault_secret" "synapse_password" {
  name         = var.synapse_workspace.sql_secret_password
  key_vault_id = data.azurerm_key_vault.synapse_secret_keyvault.id
}

## Subnet and DNS Zone for private endpoint
data "azurerm_subnet" "subnet_private_endpoint" {
  for_each             = var.synapse_pvt_endpnt
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_rg_name
}

## Get existing storage account id

data "azurerm_storage_account" "storage_account" {
  name                = var.synapse_workspace.storage_account_name
  resource_group_name = var.synapse_workspace.storage_account_rg
}