resource "azurerm_app_service_virtual_network_swift_connection" "func_app" {
    for_each       = var.func_app_vnets
    app_service_id = azurerm_linux_function_app.linux_function_app.id
    subnet_id      = data.azurerm_subnet.func_app_std_vnet[each.key].id
}