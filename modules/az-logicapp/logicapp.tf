resource "azurerm_logic_app_workflow" "logic_app_workflow" {
  name                               = "lgapp-rms-${var.logic_app_workflow.env}-uks-${var.logic_app_workflow.instance_number}"
  location                           = var.logic_app_workflow.location
  resource_group_name                = var.logic_app_workflow.resource_group_name
  integration_service_environment_id = try(var.logic_app_workflow.integration_service_environment_id, null)
  logic_app_integration_account_id   = try(var.logic_app_workflow.logic_app_integration_account_id, null)
  workflow_schema                    = try(var.logic_app_workflow.workflow_schema, null)
  workflow_version                   = try(var.logic_app_workflow.workflow_version, null)
  parameters                         = try(var.logic_app_workflow.parameters, null)
  tags                               = try(var.logic_app_workflow.tags, null)

  dynamic "identity" {
    for_each = try(var.logic_app_workflow.identity, null) != null ? [var.logic_app_workflow.identity] : []
    content {
      type         = try(identity.value.type, "SystemAssigned")
      identity_ids = try(identity.value.identity_ids, null)
    }
  }
}