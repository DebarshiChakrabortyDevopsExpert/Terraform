<H1>  Module Release Note for V1.0.0 </H1>

|       Version       | Creation Date |  Description                                    | Author                 |
| ------------------- | ------------- | ----------------------------------------------  | ---------------------  |
|         1.0.0       | 3/6/2023   | Azure Synapse  .  | Debarshi Chakraborty in IAC Team  |

**Sample Tfvars file to create Azure Synapse **

```
##=====================================================================

synapse = {
  synapse1 = {
    synapse_workspace = {
      env                 = "dev"
      instance_number     = "02"
      resource_group_name = "rg-mhra-dev-uks-rms"
      location            = "uksouth"

      ## Enabled datalake
      storage_account_name = "stmhradevuksrms02"
      data_lake_gen2_name  = "dtlkermsdevuks002"
      storage_account_rg   = "rg-mhra-dev-uks-rms"
      ## synapse username and password
      key_vault_name      = "kvrms01devuks"
      key_vault_rg        = "rg-mhra-dev-uks-rms"
      sql_secret_admin    = "sqladminrms"
      sql_secret_password = "sqlpasswordrms"

      data_exfiltration_protection_enabled = true
      managed_virtual_network_enabled      = true
      public_network_access_enabled        = false
      sql_identity_control_enabled         = false

      identity = {
        type = "SystemAssigned"
      }
      tags = {
        "application"  = "RMS",
        "costcentre"   = "tbc",
        "createdby"    = "IaC",
        "creationdate" = "tbc",
        "datatype"     = "tbc",
        "environment"  = "DEV",
        "hostname"     = "tbc",
        "name"         = "tbc",
        "owner"        = "RMS",
        "projectcode"  = "tbc",
        "role"         = "tbc"
      }
    }

    synapse_sql_pool = {
      pool1 = {
        name        = "synapsepool1"
        sku_name    = "DW100c"
        create_mode = "Default"
        collation   = "SQL_LATIN1_GENERAL_CP1_CI_AS"
      }
    }

    synapse_pvt_endpnt = {
      synapsepep1 = {
        name                    = "priep-synapse-rms-dev-uks-01"
        location                = "uksouth"
        resource_group_name     = "rg-mhra-dev-uks-rms"
        subnet_name             = "snet-mhra-dev-uks-h1s01-data"
        vnet_name               = "vnet-mhra-dev-uks-h1s01"
        vnet_rg_name            = "rg-mhra-dev-uks-network"
        private_connection_name = "prisc-synapse-rms-dev-uks-01"
        private_dns_zone_group = {
          name = "synapsegroup"
          dnszones = {
            zone1 = {
              dns_zone_name    = "privatelink.sql.azuresynapse.net"
              dns_zone_rg_name = "rg-mhra-cnct-uks-network"
            }
          }
        }
      }
    }

    synapse_diagnostics_settings = {
      ds1 = {
        name                           = "Synapse Logs and Metrics"
        log_analytics_destination_type = "Dedicated"
        log_analytics_workspace_id     = "/subscriptions/b9306b0a-2efb-4dcc-8807-51afa375586d/resourceGroups/rg-mhra-mgmt-uks-monitoring/providers/Microsoft.OperationalInsights/workspaces/lw-mhra-mgmt-uks-01"
  
        log =[
          {  
          category_group = "allLogs"  
          enabled    = true  
          }
        ]
        
        metric = [
          {
          category = "AllMetrics"
          enabled  = true
          }
        ]
      }
    }    
  }
}

```
