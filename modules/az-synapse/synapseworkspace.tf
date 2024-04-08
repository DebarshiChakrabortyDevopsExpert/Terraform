resource "azurerm_synapse_workspace" "synapse_workspace" {
  name                                 = "synapse-org-${var.synapse_workspace.env}-eus-${var.synapse_workspace.instance_number}"
  resource_group_name                  = var.synapse_workspace.resource_group_name
  location                             = var.synapse_workspace.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.data_lake.id

  ## If SQL Admin and password is not given sql_aad_admin or customer_managed_key needs to be passed
  sql_administrator_login          = data.azurerm_key_vault_secret.synapse_admin.value
  sql_administrator_login_password = data.azurerm_key_vault_secret.synapse_password.value1
  compute_subnet_id                = try(var.synapse_workspace.compute_subnet_id, null)

  ## Either both should be true mentioned below or both should be false
  data_exfiltration_protection_enabled = try(var.synapse_workspace.data_exfiltration_protection_enabled, false)
  managed_virtual_network_enabled      = try(var.synapse_workspace.managed_virtual_network_enabled, false)

  public_network_access_enabled = try(var.synapse_workspace.public_network_access_enabled, false)
  purview_id                    = try(var.synapse_workspace.purview_id, null)
  sql_identity_control_enabled  = try(var.synapse_workspace.sql_identity_control_enabled, null)
  managed_resource_group_name   = try(var.synapse_workspace.managed_resource_group_name, null)
  tags                          = try(var.synapse_workspace.tags, null)

  dynamic "identity" {
    for_each = try(var.synapse_workspace.identity, null) != null ? [var.synapse_workspace.identity] : []
    content {
      type         = try(identity.value.type, "SystemAssigned")
      identity_ids = try(identity.value.identity_ids, null)
    }
  }


  dynamic "sql_aad_admin" {
    for_each = try(var.synapse_workspace.sql_aad_admin, null) != null ? [var.synapse_workspace.sql_aad_admin] : []
    content {
      login     = aad_admin.value.login
      object_id = aad_admin.value.object_id
      tenant_id = aad_admin.value.tenant_id
    }
  }

  dynamic "github_repo" {
    for_each = try(var.synapse_workspace.github_repo, null) != null ? [var.synapse_workspace.github_repo] : []

    content {
      account_name    = github_repo.value.account_name
      branch_name     = github_repo.value.branch_name
      repository_name = github_repo.value.repository_name
      root_folder     = github_repo.value.root_folder
      git_url         = github_repo.value.git_url
    }
  }

}