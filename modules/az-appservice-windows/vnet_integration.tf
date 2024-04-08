resource "azurerm_app_service_virtual_network_swift_connection" "webapp_vnet" {
    for_each       = var.webapp_vnets
    app_service_id = azurerm_windows_web_app.windows_web_app.id
    subnet_id      = data.azurerm_subnet.webapp_std_vnet[each.key].id
}