####################
### APP SVC PLAN   #
####################
service_plan = {
  winsp1 = {
    env                 = "uat"
    instance_number     = "01"
    resource_group_name = "rg-org-uat-eus-org"
    location            = "eastus"
    os_type             = "Windows"
    sku_name            = "S2"
    tags = {
      "application"  = "org",
      "createdby"    = "IaC"
    }
  }
  linxsp1 = {
    env                 = "uat"
    instance_number     = "02"
    resource_group_name = "rg-org-uat-eus-org"
    location            = "eastus"
    os_type             = "Linux"
    sku_name            = "EP2"
    tags = {
      "application"  = "org".
      "createdby"    = "IaC"
    }
  }
  winsp2 = {
    env                 = "uat"
    instance_number     = "03"
    resource_group_name = "rg-org-uat-eus-org"
    location            = "eastus"
    os_type             = "Windows"
    sku_name            = "WS1"
    tags = {
      "application"  = "org",
      "createdby"    = "IaC"
    }
  }
}


####################
### APP SERVICE   ##
####################
windows_web_app = {
  
  web_app1 = {
    windows_web_app = {  
      env                       = "uat"
      instance_number           = "01"
      resource_group_name       = "rg-org-uat-eus-org"
      location                  = "eastus"
      service_plan_name         = "asp-org-uat-eus-01"
      service_plan_rg           = "rg-org-uat-eus-org"
      application_insights_name = "appi-org-uat-eus-001"
      application_insights_rg   = "rg-org-uat-eus-monitoring"
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
          physical_path = "site\\wwwroot\\dist"
          preload       = false
          virtual_path  = "/"
        }

        ip_restriction = {
          ip_address = "xx.x.xx.x/25"
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
        "createdby"    = "IaC",
      }
    }
    webapp_vnets = {
            vnet1 = {
                subnet_name             = "snet-org-uat-eus-appservicessubnet"
                vnet_name               = "vnet-org-uat-eus"
                vnet_rg_name            = "rg-org-uat-eus-network"
            }
      }
      
      webapp_diagnostics_settings = {
        ds1 = {
          name                           = "web App Logs and Metrics"
          log_analytics_destination_type = "Dedicated"
          log_analytics_workspace_id     = "/subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/resourceGroups/rg-org-mgmt-eus-monitoring/providers/Microsoft.OperationalInsights/workspaces/lw-org-mgmt-eus-01"
          
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
                name                    = "priep-webapp-org-uat-eus-01"
                location                = "eastus"
                resource_group_name     = "rg-org-uat-eus-org"
                subnet_name             = "snet-org-uat-eus-app"
                vnet_name               = "vnet-org-uat-eus"
                vnet_rg_name            = "rg-org-uat-eus-network"
                private_connection_name = "prisc-webapp-org-uat-eus-01"
                private_dns_zone_group = {
                name = "webappzonegroup"
                dnszones = {
                    zone1 = {
                    dns_zone_name    = "privatelink.azurewebsites.net"
                    dns_zone_rg_name = "rg-org-cnct-eus-network"
                    }
                }
                }
            }
      }
  }
}

############################
##      FUCTION APP       ##
############################
linux_function_app = {
  function_app1 = {
    linux_function_app = {
      env                  = "uat"
      instance_number      = "01"
      resource_group_name  = "rg-org-uat-eus-org"
      location             = "eastus"
      https_only           = true
      service_plan_name    = "asp-org-uat-eus-02"
      service_plan_rg      = "rg-org-uat-eus-org"
      storage_account_name = "storguateusorg01"
      storage_rg_name      = "rg-org-uat-eus-org"
      application_insights_name = "appi-org-uat-eus-001"
      application_insights_rg   = "rg-org-uat-eus-monitoring"
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
          subnet_name             = "snet-org-uat-eus-azfuncsubnet"
          vnet_name               = "vnet-org-uat-eus"
          vnet_rg_name            = "rg-org-uat-eus-network"
        }
    }
 
    function_app_pvt_endpnt = {
          funcapp_endpoint1 = {
              name                    = "priep-funapp-org-uat-eus-01"
              location                = "eastus"
              resource_group_name     = "rg-org-uat-eus-org"
              subnet_name             = "snet-org-uat-eus-app"
              vnet_name               = "vnet-org-uat-eus"
              vnet_rg_name            = "rg-org-uat-eus-network"
              private_connection_name = "prisc-funapp-org-uat-eus-01"
              private_dns_zone_group = {
                name = "funappzonegroup"
                dnszones = {
                  zone1 = {
                    dns_zone_name    = "privatelink.azurewebsites.net"
                    dns_zone_rg_name = "rg-org-cnct-eus-network"
                  }
                }
              }
          }
    }
    fun_app_diagnostics_settings = {
      ds1 = {
        name                           = "Function App Logs and Metrics"
        log_analytics_destination_type = "Dedicated"
        log_analytics_workspace_id     = "/subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/resourceGroups/rg-org-mgmt-eus-monitoring/providers/Microsoft.OperationalInsights/workspaces/lw-org-mgmt-eus-01"
        
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

############################
##      LOGIC APP       ##
############################

logic_app_standard = {
    logic_app1 = {
        logic_app_standard = {
        env                  = "uat"
        instance_number      = "01"
        resource_group_name  = "rg-org-uat-eus-org"
        location             = "eastus"
        service_plan_name    = "asp-org-uat-eus-03"
        service_plan_rg      = "rg-org-uat-eus-org"
        storage_account_name = "storguateusorg01"
        storage_rg_name      = "rg-org-uat-eus-org"
        application_insights_name = "appi-org-uat-eus-001"
        application_insights_rg   = "rg-org-uat-eus-monitoring"
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
                  subnet_name             = "snet-org-uat-eus-lgappsubnet"
                  vnet_name               = "vnet-org-uat-eus"
                  vnet_rg_name            = "rg-org-uat-eus-network"
            }
        }
        logic_app_std_pvt_endpnt = {
            pvtendpoint1 = {
                name                    = "priep-logicapp-org-uat-eus-01"
                location                = "eastus"
                resource_group_name     = "rg-org-uat-eus-org"
                subnet_name             = "snet-org-uat-eus-app"
                vnet_name               = "vnet-org-uat-eus"
                vnet_rg_name            = "rg-org-uat-eus-network"
                private_connection_name = "prisc-logicapp-org-uat-eus-01"
                private_dns_zone_group = {
                  name = "logicappstdgroup"
                  dnszones = {
                    zone1 = {
                      dns_zone_name    = "privatelink.azurewebsites.net"
                      dns_zone_rg_name = "rg-org-cnct-eus-network"
                    }
                  }
                }
            }
      }
      logicapp_std_diagnostics_settings = {
        ds1 = {
          name                           = "Logic App Logs and Metrics"
          log_analytics_destination_type = "Dedicated"
          log_analytics_workspace_id     = "/subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/resourceGroups/rg-org-mgmt-eus-monitoring/providers/Microsoft.OperationalInsights/workspaces/lw-org-mgmt-eus-01"
          
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
