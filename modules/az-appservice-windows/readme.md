<H1>  Module Release Note for V1.0.0 </H1>

|       Version       | Creation Date |  Description                                    | Author                 |
| ------------------- | ------------- | ----------------------------------------------  | ---------------------  |
|         1.0.0       | 4/8/2024   | Azure Application Service Windows Terraform module .  | Debarshi Chakraborty in IAC Team  |

**Sample Tfvars file to create Azure Application Service Windows**


```
##=====================================================================

windows_web_app = {
  
  web_app1 = {
    windows_web_app = {  
      env                       = "prod"
      instance_number           = "01"
      resource_group_name       = "rg-org-prod-uks-org"
      location                  = "uksouth"
      service_plan_name         = "asp-org-prod-uks-01"
      service_plan_rg           = "rg-org-prod-uks-org"
      application_insights_name = "appi-org-prod-uks-001"
      application_insights_rg   = "rg-org-prod-uks-monitoring"
      client_certificate_enabled = "true"
      client_certificate_mode    = "Required"
      app_settings = {
        WEBSITE_RUN_FROM_PACKAGE=1
      }

      identity = {
        type = "SystemAssigned"
      }

      site_config = {
        always_on                = false
        worker_count             = 1
        ftps_state               = "FtpsOnly"
        http2_enabled            = false
        minimum_tls_version      = "1.2"
        remote_debugging_enabled = false

        application_stack = {
          current_stack  = "node"
          node_version   = "16-LTS"
        }

        virtual_application = {
          physical_path = "site\\wwwroot"
          preload       = false
          virtual_path  = "/"
        }

        ip_restriction = {
          ip_address = "10.5.83.0/25"
          name       = "rule1"
          priority   = 300
          action     = "Allow"
        }
      }

      auth_settings = {
        default_provider              = "Github"
        enabled                       = false
        unauthenticated_client_action = "RedirectToLoginPage"
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
    }
      webapp_slot = {
        webappslot1 = {
          web_app_slotname           = "staging"
          application_insights_name  = "appi-org-prod-uks-001"
          application_insights_rg    = "rg-org-prod-uks-monitoring"
          client_certificate_enabled = "true"
          client_certificate_mode    = "Required"
          app_settings = {
            WEBSITE_RUN_FROM_PACKAGE=1

          }

          identity = {
            type = "SystemAssigned"
          }

          site_config = {
            always_on                = true
            worker_count             = 1
            ftps_state               = "FtpsOnly"
            http2_enabled            = true
            minimum_tls_version      = "1.2"
            remote_debugging_enabled = false

            application_stack = {
              current_stack  = "node"
              node_version   = "16-LTS"
            }

            virtual_application = {
              physical_path = "site\\wwwroot"
              preload       = false
              virtual_path  = "/"
            }

            ip_restriction = {
              ip_address = "10.5.83.0/25"
              name     = "rule1"
              priority = 300
              action   = "Allow"
              }
          }

          auth_settings = {
            default_provider              = "Github"
            enabled                       = false
            unauthenticated_client_action = "RedirectToLoginPage"
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
        }        
      }

      webapp_vnets = {
            vnet1 = {
                subnet_name             = "snet-org-prod-uks-appservicessubnet"
                vnet_name               = "vnet-org-prod-uks"
                vnet_rg_name            = "rg-org-prod-uks-network"
            }
      }
      
      webapp_diagnostics_settings = {
        ds1 = {
          name                           = "web App Logs and Metrics"
          log_analytics_destination_type = "Dedicated"
          log_analytics_workspace_id     = "/subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/resourceGroups/rg-org-mgmt-uks-monitoring/providers/Microsoft.OperationalInsights/workspaces/lw-org-mgmt-uks-01"
          
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
      webapp_private_endpoint = {
          webapp_endpoint1 = {
                name                    = "priep-webapp-org-prod-uks-01"
                location                = "uksouth"
                resource_group_name     = "rg-org-prod-uks-org"
                subnet_name             = "snet-org-prod-uks-h1s01-app"
                vnet_name               = "vnet-org-prod-uks-h1s01"
                vnet_rg_name            = "rg-org-prod-uks-network"
                private_connection_name = "prisc-webapp-org-prod-uks-01"
                private_dns_zone_group = {
                name = "webappzonegroup"
                dnszones = {
                    zone1 = {
                    dns_zone_name    = "privatelink.azurewebsites.net"
                    dns_zone_rg_name = "rg-org-cnct-uks-network"
                    }
                }
                }
            }
      }
      ## Azure webapp service slot private endpoint
      webapp_private_endpoint_slot = {
                webapp_endpoint1 = {
                      name                    = "priep-webappslot-org-prod-uks-01"
                      location                = "uksouth"
                      web_app_slot_key        = "webappslot1"
                      slot_name               = "staging"    
                      resource_group_name     = "rg-org-prod-uks-org"
                      subnet_name             = "snet-org-prod-uks-h1s01-app"
                      vnet_name               = "vnet-org-prod-uks-h1s01"
                      vnet_rg_name            = "rg-org-prod-uks-network"        
                      private_connection_name = "prisc-webappslot-org-prod-uks-01"
                      private_dns_zone_group = {
                      name = "webappzonegroup2"
                      dnszones = {
                          zone1 = {
                          dns_zone_name    = "privatelink.azurewebsites.net"
                          dns_zone_rg_name = "rg-org-cnct-uks-network"
                          }
                      }
                      }
                  }
      } 
  }
}

```
