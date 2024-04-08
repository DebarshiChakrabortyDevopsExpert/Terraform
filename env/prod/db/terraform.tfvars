###########################
##      SQL SERVERS       #
###########################
sql_servers = {

  sql_server1 = {
    ms_sql_server = {
      env                           = "prod"
      instance_number               = "01"
      resource_group_name           = "rg-org-prod-eus-org"
      location                      = "eastus"
      key_vault_name                = "kvorg01prodeus"
      key_vault_rg                  = "rg-org-prod-eus-org"
      sql_admin_secret_name         = "sqladminorg"
      sql_password_secret_name      = "sqlpasswordorg"
      public_network_access_enabled = false

      identity = {
        type = "SystemAssigned"
      }

      azuread_administrator = {
        azuread_authentication_only = false
        login_username              = "xxxxx.xxxx@org.org.com"
        object_id                   = "xxxxx"
        tenant_id                   = "xxxxx"
      }

      tags = {
        "application"  = "org",
        "createdby"    = "IaC",
      }
    }

    ## Mention the allowed ip from where the sql server will be accessed
    ms_sql_server_firewall_rule = {
      fwrule1 = {
        env              = "prod"
        instance_number  = "01"
        start_ip_address = "0.0.0.0"
        end_ip_address   = "0.0.0.0"
      }
    }

    ms_sql_server_auditing_policy = {
      policy1 = {
        auditing_policy_storage_account_name    = "storgprodeusorg01"
        auditing_policy_storage_account_rg_name = "rg-org-prod-eus-org"
        enabled                                 = true
        storage_account_access_key_is_secondary = false
        retention_in_days                       = 30
        log_monitoring_enabled                  = false
      }
    }

    #sql server security audit policy
    ms_sql_security_alert_policy = {
        securitypolicy1 = {
            resource_group_name                     = "rg-org-prod-eus-org"
            state                                   = "Enabled"
            email_account_admins                    = false
            email_addresses                         = ["xxxxxx@org.org.com"]
            disabled_alerts                         = ["Sql_Injection","Data_Exfiltration"]
            retention_days                          = 30
            security_policy_storage_account_name    = "storgprodeusorg01"
            security_policy_storage_account_rg_name = "rg-org-prod-eus-org"
        }
    }

    ## Create Elastic Pool
    mssql_elasticpool = {
      ep1 = {
        env                 = "prod"
        instance_number     = "01"
        resource_group_name = "rg-org-prod-eus-org"
        location            = "eastus"
        license_type        = "LicenseIncluded"
        max_size_gb         = 400
        sku = {
          name     = "StandardPool"
          tier     = "Standard"
          capacity = 400
        }
        per_database_settings = {
          min_capacity = 0
          max_capacity = 400
        }

      tags = {
        "application"  = "org",
        "createdby"    = "IaC",
      }
      }
    }

    ## Create SQL Database
    ms_sql_database = {
      sqldb1 = {
        name                                     = "org-db"
        collation                                = "SQL_Latin1_General_CP1_CI_AS"
        sku_name                                 = "ElasticPool"
        key                                      = "ep1"
        geo_backup_enabled                       = true
        auto_pause_delay_in_minutes              = 0
        storage_account_type                     = "Local"
        threat_detection_storage_account_name    = "storgprodeusorg01"
        threat_detection_storage_account_rg_name = "rg-org-prod-eus-org"

        threat_detection_policy = {
          state                = "Enabled"
          disabled_alerts      = ["Access_Anomaly"]
          email_account_admins = "Disabled"
          email_addresses      = ["DevOpsSupport@org.org.com"]
          retention_days       = 90
        }

      tags = {
        "application"  = "org",
        "createdby"    = "IaC",
      }
      }
    }

    ## Enable private endpoint for SQL Server
    ms_sql_server_private_endpoint = {
      pvtendpoint1 = {
        name                    = "priep-sqldb-org-prod-eus-01"
        location                = "eastus"
        resource_group_name     = "rg-org-prod-eus-org"
        subnet_name             = "snet-org-prod-eus-data"
        vnet_name               = "vnet-org-prod-eus"
        vnet_rg_name            = "rg-org-prod-eus-network"
        private_connection_name = "prisc-sqldb-org-prod-eus-01"
        private_dns_zone_group = {
          name = "sqldatabasegroup"
          dnszones = {
            zone1 = {
              dns_zone_name    = "privatelink.database.windows.net"
              dns_zone_rg_name = "rg-org-cnct-eus-network"
            }
          }
        }
      }
    }
  }
}

##########################
###     SYNAPSE        ###
##########################

synapse = {
  synapse1 = {
    synapse_workspace = {
      env                               = "prod"
      instance_number                   = "02"
      resource_group_name               = "rg-org-prod-eus-org"
      location                          = "eastus"

      ## Enabled datalake
      
      storage_account_name              = "storgprodeusorg02"
      data_lake_gen2_name               = "dtlkeorgprodeus002"
      storage_account_rg                = "rg-org-prod-eus-org"
      
      ## synapse username and password

      key_vault_name                    = "kvorg01prodeus"
      key_vault_rg                      = "rg-org-prod-eus-org"
      sql_secret_admin                  = "sqladminorg"
      sql_secret_password               = "sqlpasswordorg"

      data_exfiltration_protection_enabled = true
      managed_virtual_network_enabled      = true
      public_network_access_enabled        = false
      sql_identity_control_enabled         = false

      identity = {
        type = "SystemAssigned"
      }
      tags = {
        "application"  = "org",
        "createdby"    = "IaC",
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
        name                    = "priep-synapse-org-prod-eus-01"
        location                = "eastus"
        resource_group_name     = "rg-org-prod-eus-org"
        subnet_name             = "snet-org-prod-eus-data"
        vnet_name               = "vnet-org-prod-eus"
        vnet_rg_name            = "rg-org-prod-eus-network"
        private_connection_name = "prisc-synapse-org-prod-eus-01"
        private_dns_zone_group = {
          name = "synapsegroup"
          dnszones = {
            zone1 = {
              dns_zone_name    = "privatelink.sql.azuresynapse.net"
              dns_zone_rg_name = "rg-org-cnct-eus-network"
            }
          }
        }
      }
    }

    synapse_diagnostics_settings = {
      ds1 = {
        name                           = "Synapse Logs and Metrics"
        log_analytics_destination_type = "Dedicated"
        log_analytics_workspace_id     = "/subscriptions/xxxxxxxxxxxxxxxxxxxxxx/resourceGroups/rg-org-mgmt-eus-monitoring/providers/Microsoft.OperationalInsights/workspaces/lw-org-mgmt-eus-01"
        
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
