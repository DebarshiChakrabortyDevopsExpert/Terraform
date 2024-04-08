resource "azurerm_synapse_sql_pool" "synapse_sql_pool" {
  for_each             = var.synapse_sql_pool
  name                 = each.value.name
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  sku_name             = try(each.value.sku_name, "DW100c")
  create_mode          = try(each.value.create_mode, "Default")
  collation            = try(each.value.collation, "SQL_LATIN1_GENERAL_CP1_CI_AS")
  tags                 = try(each.value.tags, null)
}