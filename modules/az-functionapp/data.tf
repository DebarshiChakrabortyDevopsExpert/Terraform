data "azurerm_service_plan" "service_plan" {
  name                = var.linux_function_app.service_plan_name
  resource_group_name = var.linux_function_app.service_plan_rg
}

data "azurerm_application_insights" "exiting_application_insights" {
  name                = var.linux_function_app.application_insights_name
  resource_group_name = var.linux_function_app.application_insights_rg
}

data "azurerm_storage_account" "storage_account" {
  name                = var.linux_function_app.storage_account_name
  resource_group_name = var.linux_function_app.storage_rg_name
}

## Subnet and dns zone for private endpoint
data "azurerm_subnet" "subnet_private_endpoint" {
  for_each             = var.function_app_pvt_endpnt
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_rg_name
}

## Subnet and private endpoint for web app slot
data "azurerm_subnet" "subnet_private_endpoint_slot" {
  for_each             = var.function_app_slot_pvt_endpnt
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_rg_name
}

## Subnet for VNet Integrations
data "azurerm_subnet" "func_app_std_vnet" {
    for_each              = var.func_app_vnets
    name                  = each.value.subnet_name
    virtual_network_name  = each.value.vnet_name
    resource_group_name   = each.value.vnet_rg_name
}