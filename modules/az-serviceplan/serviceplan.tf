resource "azurerm_service_plan" "service_plan" {
  for_each            = var.service_plan
  name                = "asp-org-${each.value.env}-uks-${each.value.instance_number}"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  os_type             = try(each.value.os_type, "Windows")
  sku_name            = try(each.value.sku_name, "F1")
  tags                = try(each.value.tags, null)
}