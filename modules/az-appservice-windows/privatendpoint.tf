## Private endpoint for webapp
resource "azurerm_private_endpoint" "private_endpoint_webapp" {
  for_each            = var.webapp_private_endpoint
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet_private_endpoint[each.key].id
  tags                = try(each.value.tags, null)

  private_service_connection {
    name                           = each.value.private_connection_name
    private_connection_resource_id = azurerm_windows_web_app.windows_web_app.id
    is_manual_connection           = try(each.value.is_manual_connection, false)
    subresource_names              = try(each.value.subresource_names, ["sites"])
  }

  dynamic "private_dns_zone_group" {
    for_each = try(each.value.private_dns_zone_group, null) != null ? [each.value.private_dns_zone_group] : []
    content {
      name                 = try(private_dns_zone_group.value.name, null)
      private_dns_zone_ids = flatten([for ids, value in try(private_dns_zone_group.value.dnszones, null) : "/subscriptions/eb20d232-22b9-4915-9b81-6bbe3bb7344a/resourceGroups/${value.dns_zone_rg_name}/providers/Microsoft.Network/privateDnsZones/${value.dns_zone_name}"])
    }
  }
}

## Private endpoint for webapp slot
resource "azurerm_private_endpoint" "private_endpoint_webapp_slot" {
  for_each            = var.webapp_private_endpoint_slot
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet_private_endpoint_slot[each.key].id
  tags                = try(each.value.tags, null)

  private_service_connection {
    name                           = each.value.private_connection_name
    private_connection_resource_id = azurerm_windows_web_app.windows_web_app.id
    is_manual_connection           = try(each.value.is_manual_connection, false)
    subresource_names              = try(each.value.subresource_names, ["sites-${each.value.slot_name}"])
  }

  dynamic "private_dns_zone_group" {
    for_each = try(each.value.private_dns_zone_group, null) != null ? [each.value.private_dns_zone_group] : []
    content {
      name                 = try(private_dns_zone_group.value.name, null)
      private_dns_zone_ids = flatten([for ids, value in try(private_dns_zone_group.value.dnszones, null) : "/subscriptions/eb20d232-22b9-4915-9b81-6bbe3bb7344a/resourceGroups/${value.dns_zone_rg_name}/providers/Microsoft.Network/privateDnsZones/${value.dns_zone_name}"])
    }
  }
}
