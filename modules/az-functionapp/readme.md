<H1>  Module Release Note for V1.0.0 </H1>

|       Version       | Creation Date |  Description                                    | Author                 |
| ------------------- | ------------- | ----------------------------------------------  | ---------------------  |
|         1.0.0       | 3/6/2023   | Azure Linux Function App .  | Debarshi Chakraborty in IAC Team  |

**Sample Tfvars file to create Azure Linux Function App**

```
##=====================================================================

 linux_function_app = {
  function_app1 = {
    linux_function_app = {
      env                  = "prod"
      instance_number      = "01"
      resource_group_name  = "rg-org-prod-uks-org"
      location             = "uksouth"
      https_only           = true
      service_plan_name    = "asp-org-prod-uks-02"
      service_plan_rg      = "rg-org-prod-uks-org"
      storage_account_name = "storgproduksorg01"
      storage_rg_name      = "rg-org-prod-uks-org"
      application_insights_name = "appi-org-prod-uks-001"
      application_insights_rg   = "rg-org-prod-uks-monitoring"
      app_settings = {
        WEBSITE_RUN_FROM_PACKAGE=1

      }
      tags = {
        "application"  = "org",
        "costcentre"   = "tbc",
        "createdby"    = "IaC",
        "creationdate" = "tbc",
        "datatype"     = "tbc",
        "environment"  = "PROD",
        "hostname"     = "tbc",
        "name"         = "tbc",
        "owner"        = "org",
        "projectcode"  = "tbc",
        "role"         = "tbc"
      }

      identity = {
        type = "SystemAssigned"
      }

      site_config = {
        always_on           = false
        worker_count        = 1
        ftps_state          = "FtpsOnly"
        http2_enabled       = true
        minimum_tls_version = "1.2"
        application_stack = {
          node_version = "16"
        }

        ip_restriction = {
        ip_address = "10.5.83.0/25"
        name       = "rule1"
        priority   = 300
        action     = "Allow"
      }
      }
    }
    func_app_vnets = {
        vnet1 = {
          subnet_name             = "snet-org-prod-uks-h1s01-azfuncsubnet"
          vnet_name               = "vnet-org-prod-uks-h1s01"
          vnet_rg_name            = "rg-org-prod-uks-network"
        }
    }
    linux_function_app_slot = {
      funappslot1 = {
        fun_app_slotname          = "staging"
        storage_account_name      = "storgproduksorg01"
        storage_rg_name           = "rg-org-prod-uks-org"
        https_only                = true
        application_insights_name = "appi-org-prod-uks-001"
        application_insights_rg   = "rg-org-prod-uks-monitoring"
        app_settings = {
          WEBSITE_RUN_FROM_PACKAGE=1
        }
        tags = {
          "application"  = "org",
          "createdby"    = "IaC",
        }

        identity = {
          type = "SystemAssigned"
        }

        site_config = {
          always_on           = false
          worker_count        = 1
          ftps_state          = "FtpsOnly"
          http2_enabled       = true
          minimum_tls_version = "1.2"
          application_stack = {
            node_version = "16"
          }
        }
      }
    }
    function_app_pvt_endpnt = {
          funcapp_endpoint1 = {
              name                    = "priep-funapp-org-prod-uks-01"
              location                = "uksouth"
              resource_group_name     = "rg-org-prod-uks-org"
              subnet_name             = "snet-org-prod-uks-h1s01-app"
              vnet_name               = "vnet-org-prod-uks-h1s01"
              vnet_rg_name            = "rg-org-prod-uks-network"
              private_connection_name = "prisc-funapp-org-prod-uks-01"
              private_dns_zone_group = {
                name = "funappzonegroup"
                dnszones = {
                  zone1 = {
                    dns_zone_name    = "privatelink.azurewebsites.net"
                    dns_zone_rg_name = "rg-org-cnct-uks-network"
                  }
                }
              }
          }
    }
    function_app_slot_pvt_endpnt = {
          funcapp_endpoint1 = {
              name                    = "priep-funappslot-org-prod-uks-01"
              location                = "uksouth"
              resource_group_name     = "rg-org-prod-uks-org"
              slot_name               = "staging"
              subnet_name             = "snet-org-prod-uks-h1s01-app"
              vnet_name               = "vnet-org-prod-uks-h1s01"
              vnet_rg_name            = "rg-org-prod-uks-network"
              private_connection_name = "prisc-funappslot-org-prod-uks-01"
              private_dns_zone_group = {
                name = "funappzonegroup2"
                dnszones = {
                  zone1 = {
                    dns_zone_name    = "privatelink.azurewebsites.net"
                    dns_zone_rg_name = "rg-org-cnct-uks-network"
                  }
                }
              }
          }
    }
    fun_app_diagnostics_settings = {
      ds1 = {
        name                           = "Function App Logs and Metrics"
        log_analytics_destination_type = "Dedicated"
        log_analytics_workspace_id     = "/subscriptions/b9306b0a-2efb-4dcc-8807-51afa375586d/resourceGroups/rg-org-mgmt-uks-monitoring/providers/Microsoft.OperationalInsights/workspaces/lw-org-mgmt-uks-01"
        
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
