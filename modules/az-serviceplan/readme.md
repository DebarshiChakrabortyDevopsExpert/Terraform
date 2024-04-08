<H1>  Module Release Note for V1.0.0 </H1>

|       Version       | Creation Date |  Description                                    | Author                 |
| ------------------- | ------------- | ----------------------------------------------  | ---------------------  |
|         1.0.0       | 3/6/2023   | Azure Service Plan .  | Debarshi Chakraborty in IAC Team  |

**Sample Tfvars file to create Azure Service Plan**

```
##=====================================================================

service_plan = {
    winsp1={ 
      env                   = "dev"
      instance_number       = "01"
      resource_group_name   = "rg-mhra-dev-uks-la"
      location              = "uksouth"
      os_type               = "Windows"
      sku_name              = "F1"
    }
}
```
