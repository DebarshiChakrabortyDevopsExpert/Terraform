data "azurerm_service_plan" "logic_app_std" {
    name                = var.logic_app_standard.service_plan_name
    resource_group_name = var.logic_app_standard.service_plan_rg
}

data "azurerm_application_insights" "exiting_application_insights" {
  name                = var.logic_app_standard.application_insights_name
  resource_group_name = var.logic_app_standard.application_insights_rg
}

data "azurerm_storage_account" "logic_app_std" {
    name                = var.logic_app_standard.storage_account_name
    resource_group_name = var.logic_app_standard.storage_rg_name
}

## Subnet and private endpoint for private endpoint
data "azurerm_subnet" "subnet_private_endpoint" {
    for_each              = var.logic_app_std_pvt_endpnt
    name                  = each.value.subnet_name
    virtual_network_name  = each.value.vnet_name
    resource_group_name   = each.value.vnet_rg_name
}

## Subnet for VNet Integrations
data "azurerm_subnet" "logic_app_std_vnet" {
    for_each              = var.logic_app_std_vnets
    name                  = each.value.subnet_name
    virtual_network_name  = each.value.vnet_name
    resource_group_name   = each.value.vnet_rg_name
}