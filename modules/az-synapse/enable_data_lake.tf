resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake" {
  name               = var.synapse_workspace.data_lake_gen2_name
  storage_account_id = data.azurerm_storage_account.storage_account.id
}