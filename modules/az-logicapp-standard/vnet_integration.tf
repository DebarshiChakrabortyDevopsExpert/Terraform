resource "azurerm_app_service_virtual_network_swift_connection" "logic_app_std" {
    for_each = var.logic_app_std_vnets
    app_service_id = azurerm_logic_app_standard.logic_app_standard.id
    subnet_id      = data.azurerm_subnet.logic_app_std_vnet[each.key].id
}