<H1>  Module Release Note for V1.0.0 </H1>

|       Version       | Creation Date |  Description                                    | Author                 |
| ------------------- | ------------- | ----------------------------------------------  | ---------------------  |
|         1.0.0       | 3/6/2023   | Azure Logic App Workflow .  | Debarshi Chakraborty in IAC Team  |

**Sample Tfvars file to create Azure Logic App Workflow**

```
##=====================================================================

logic_app_workflow = {

logic1pp1 = {

      logic_app_workflow = {
        env                 = "dev"
        instance_number     = "01"
        location            = "uksouth"
        resource_group_name = "rg-mhra-dev-uks-rms"

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

      logicapp_diagnostics_settings = {
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
