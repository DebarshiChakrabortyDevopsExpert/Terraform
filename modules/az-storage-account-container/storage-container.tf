resource "azurerm_storage_container" "storage_container" {
  for_each              = var.storage_container
  name                  = each.value.name
  storage_account_name  = each.value.storage_account_name
  container_access_type = try(each.value.container_access_type, "private")
}