<H1>  Module Release Note for V1.0.0 </H1>

|       Version       | Creation Date |  Description                                    | Author                 |
| ------------------- | ------------- | ----------------------------------------------  | ---------------------  |
|         1.0.0       | 3/6/2023   | Azure Logic App Standard .  | Debarshi Chakraborty in IAC Team  |

**Sample Tfvars file to create Azure Logic App Standard**

```
##=====================================================================

logic_app_standard = {
    logic_app1 = {
        logic_app_standard = {
        env                  = "prod"
        instance_number      = "01"
        resource_group_name  = "rg-mhra-prod-uks-rms"
        location             = "uksouth"
        service_plan_name    = "asp-rms-prod-uks-03"
        service_plan_rg      = "rg-mhra-prod-uks-rms"
        storage_account_name = "stmhraproduksrms01"
        storage_rg_name      = "rg-mhra-prod-uks-rms"
        application_insights_name = "appi-mhra-prod-uks-001"
        application_insights_rg   = "rg-mhra-prod-uks-monitoring"
        app_settings = {}
        identity = {
            type = "SystemAssigned"
        }
        site_config = {
            always_on           = false
            ftps_state          = "Disabled"
            http2_enabled       = true
        }
        tags = {
        "application"  = "RMS",
        "costcentre"   = "tbc",
        "createdby"    = "IaC",
        "creationdate" = "tbc",
        "datatype"     = "tbc",
        "environment"  = "PROD",
        "hostname"     = "tbc",
        "name"         = "tbc",
        "owner"        = "RMS",
        "projectcode"  = "tbc",
        "role"         = "tbc"
        }
      }
      logic_app_std_vnets = {
          vnet1 = {
                subnet_name             = "snet-mhra-prod-uks-h1s01-lgappsubnet"
                vnet_name               = "vnet-mhra-prod-uks-h1s01"
                vnet_rg_name            = "rg-mhra-prod-uks-network"
          }
      }
      logic_app_std_pvt_endpnt = {
            pvtendpoint1 = {
                name                    = "priep-logicapp-rms-prod-uks-01"
                location                = "uksouth"
                resource_group_name     = "rg-mhra-prod-uks-rms"
                subnet_name             = "snet-mhra-prod-uks-h1s01-app"
                vnet_name               = "vnet-mhra-prod-uks-h1s01"
                vnet_rg_name            = "rg-mhra-prod-uks-network"
                private_connection_name = "prisc-logicapp-rms-prod-uks-01"
                private_dns_zone_group = {
                  name = "logicappstdgroup"
                  dnszones = {
                    zone1 = {
                      dns_zone_name    = "privatelink.azurewebsites.net"
                      dns_zone_rg_name = "rg-mhra-cnct-uks-network"
                    }
                  }
                }
            }
      }
      logicapp_std_diagnostics_settings = {
        ds1 = {
          name                           = "Logic App Logs and Metrics"
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
