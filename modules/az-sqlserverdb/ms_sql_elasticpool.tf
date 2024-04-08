resource "azurerm_mssql_elasticpool" "mssql_elasticpool" {
  for_each            = var.mssql_elasticpool
  name                = "sqlpool-org-${each.value.env}-eus-${each.value.instance_number}"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  server_name         = azurerm_mssql_server.mssqlserver.name
  license_type        = try(each.value.license_type, "LicenseIncluded")
  max_size_gb         = try(each.value.max_size_gb, 756)
  max_size_bytes      = try(each.value.max_size_bytes, null)
  zone_redundant      = try(each.value.zone_redundant, null)
  tags                = try(each.value.tags, null)

  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
    family   = try(each.value.sku.family, null)
    capacity = each.value.sku.capacity
  }

  per_database_settings {
    min_capacity = each.value.per_database_settings.min_capacity
    max_capacity = each.value.per_database_settings.max_capacity
  }
}