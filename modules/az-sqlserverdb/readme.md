<H1>  Module Release Note for V1.0.0 </H1>

|       Version       | Creation Date |  Description                                    | Author                 |
| ------------------- | ------------- | ----------------------------------------------  | ---------------------  |
|         1.0.0       | 3/6/2023   | Azure SQL Server  .  | Debarshi Chakraborty in IAC Team  |

**Sample Tfvars file to create Azure SQL Server **

```
##=====================================================================

sql_servers = {

  sql_server1 = {
    ms_sql_server = {
      env                           = "prod"
      instance_number               = "01"
      resource_group_name           = "rg-mhra-prod-uks-rms"
      location                      = "uksouth"
      key_vault_name                = "kvrms01produks"
      key_vault_rg                  = "rg-mhra-prod-uks-rms"
      sql_admin_secret_name         = "sqladminrms"
      sql_password_secret_name      = "sqlpasswordrms"
      public_network_access_enabled = false

      identity = {
        type = "SystemAssigned"
      }

      azuread_administrator = {
        azuread_authentication_only = false
        login_username              = "avik.sadhu@mhra.gov.uk"
        object_id                   = "58955a4c-46a8-4376-9ec6-423714cb6038"
        tenant_id                   = "e527ea5c-6258-4cd2-a27f-8bd237ec4c26"
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

    # SQL server auditing policy
    ms_sql_server_auditing_policy = {
      policy1 = {
        auditing_policy_storage_account_name    = "stmhraproduksrms01"
        auditing_policy_storage_account_rg_name = "rg-mhra-prod-uks-rms"
        enabled                                 = true
        storage_account_access_key_is_secondary = false
        retention_in_days                       = 30
        log_monitoring_enabled                  = false
      }
    }

    ## Create Elastic Pool
    mssql_elasticpool = {
      ep1 = {
        env                 = "prod"
        instance_number     = "01"
        resource_group_name = "rg-mhra-prod-uks-rms"
        location            = "uksouth"
        license_type        = "LicenseIncluded"
        max_size_gb         = 1536
        sku = {
          name     = "PremiumPool"
          tier     = "Premium"
          capacity = 1500
        }
        per_database_settings = {
          min_capacity = 0
          max_capacity = 500
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
    }

    ## Create SQL Database
    ms_sql_database = {
      sqldb1 = {
        name                                     = "rms-db"
        collation                                = "SQL_Latin1_General_CP1_CI_AS"
        sku_name                                 = "ElasticPool"
        key                                      = "ep1"
        geo_backup_enabled                       = true
        auto_pause_delay_in_minutes              = 0
        storage_account_type                     = "Local"
        threat_detection_storage_account_name    = "stmhraproduksrms01"
        threat_detection_storage_account_rg_name = "rg-mhra-prod-uks-rms"

        threat_detection_policy = {
          state                = "Enabled"
          disabled_alerts      = ["Access_Anomaly"]
          email_account_admins = "Disabled"
          email_addresses      = ["DevOpsSupport@mhra.gov.uk"]
          retention_days       = 90
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
    }

    ## Enable private endpoint for SQL Server
    ms_sql_server_private_endpoint = {
      pvtendpoint1 = {
        name                    = "priep-sqldb-rms-prod-uks-01"
        location                = "uksouth"
        resource_group_name     = "rg-mhra-prod-uks-rms"
        subnet_name             = "snet-mhra-prod-uks-h1s01-data"
        vnet_name               = "vnet-mhra-prod-uks-h1s01"
        vnet_rg_name            = "rg-mhra-prod-uks-network"
        private_connection_name = "prisc-sqldb-rms-prod-uks-01"
        private_dns_zone_group = {
          name = "sqldatabasegroup"
          dnszones = {
            zone1 = {
              dns_zone_name    = "privatelink.database.windows.net"
              dns_zone_rg_name = "rg-mhra-cnct-uks-network"
            }
          }
        }
      }
    }
  }
}
```
