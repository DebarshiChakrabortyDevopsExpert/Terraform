module "synapse" {
  source             = "../../../modules/az-synapse"
  for_each           = var.synapse
  synapse_sql_pool   = try(each.value.synapse_sql_pool, {})
  synapse_workspace  = try(each.value.synapse_workspace, {})
  synapse_pvt_endpnt = try(each.value.synapse_pvt_endpnt, {})
  synapse_diagnostics_settings = try(each.value.synapse_diagnostics_settings, {})
}

module "ms_sql_server" {
  source                        = "../../../modules/az-sqlserverdb"
  for_each                      = var.sql_servers
  ms_sql_server                 = try(each.value.ms_sql_server, {})
  mssql_elasticpool             = try(each.value.mssql_elasticpool, {})
  ms_sql_database               = try(each.value.ms_sql_database, {})
  ms_sql_server_firewall_rule   = try(each.value.ms_sql_server_firewall_rule, {})
  ms_sql_server_vnet_rule       = try(each.value.ms_sql_server_vnet_rule, {})
  ms_sql_server_pvt_endpnt      = try(each.value.ms_sql_server_private_endpoint, {})
  ms_sql_server_auditing_policy = try(each.value.ms_sql_server_auditing_policy, {})
  ms_sql_security_alert_policy  = try(each.value.ms_sql_security_alert_policy, {})
}