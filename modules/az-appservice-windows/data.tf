data "azurerm_service_plan" "windows_web_app" {
  name                = var.windows_web_app.service_plan_name
  resource_group_name = var.windows_web_app.service_plan_rg
}

data "azurerm_application_insights" "exiting_application_insights" {
  name                = var.windows_web_app.application_insights_name
  resource_group_name = var.windows_web_app.application_insights_rg
}

## Subnet and private endpoint for webapp
data "azurerm_subnet" "subnet_private_endpoint" {
  for_each             = var.webapp_private_endpoint
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_rg_name
}

## Subnet and private endpoint for web app slot
data "azurerm_subnet" "subnet_private_endpoint_slot" {
  for_each             = var.webapp_private_endpoint_slot
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_rg_name
}

## Subnet for VNet Integrations
data "azurerm_subnet" "webapp_std_vnet" {
    for_each              = var.webapp_vnets
    name                  = each.value.subnet_name
    virtual_network_name  = each.value.vnet_name
    resource_group_name   = each.value.vnet_rg_name
}