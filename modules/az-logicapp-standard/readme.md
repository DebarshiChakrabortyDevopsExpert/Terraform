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
        resource_group_name  = "rg-org-prod-uks-org"
        location             = "uksouth"
        service_plan_name    = "asp-org-prod-uks-03"
        service_plan_rg      = "rg-org-prod-uks-org"
        storage_account_name = "storgproduksorg01"
        storage_rg_name      = "rg-org-prod-uks-org"
        application_insights_name = "appi-org-prod-uks-001"
        application_insights_rg   = "rg-org-prod-uks-monitoring"
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
        "application"  = "org",
        "createdby"    = "IaC",
        }
      }
      logic_app_std_vnets = {
          vnet1 = {
                subnet_name             = "snet-org-prod-uks-h1s01-lgappsubnet"
                vnet_name               = "vnet-org-prod-uks-h1s01"
                vnet_rg_name            = "rg-org-prod-uks-network"
          }
      }
      logic_app_std_pvt_endpnt = {
            pvtendpoint1 = {
                name                    = "priep-logicapp-org-prod-uks-01"
                location                = "uksouth"
                resource_group_name     = "rg-org-prod-uks-org"
                subnet_name             = "snet-org-prod-uks-h1s01-app"
                vnet_name               = "vnet-org-prod-uks-h1s01"
                vnet_rg_name            = "rg-org-prod-uks-network"
                private_connection_name = "prisc-logicapp-org-prod-uks-01"
                private_dns_zone_group = {
                  name = "logicappstdgroup"
                  dnszones = {
                    zone1 = {
                      dns_zone_name    = "privatelink.azurewebsites.net"
                      dns_zone_rg_name = "rg-org-cnct-uks-network"
                    }
                  }
                }
            }
      }
      logicapp_std_diagnostics_settings = {
        ds1 = {
          name                           = "Logic App Logs and Metrics"
          log_analytics_destination_type = "Dedicated"
          log_analytics_workspace_id     = "/subscriptions/xxxxxxxxxxxxxxxxxxxxxxx/resourceGroups/rg-org-mgmt-uks-monitoring/providers/Microsoft.OperationalInsights/workspaces/lw-org-mgmt-uks-01"
          
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
