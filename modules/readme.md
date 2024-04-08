
<H1> Terraform Modules By Debarshi chakraborty</H1>

- This Folder consists of Terraform modules for multiple Azure Resources

<H1> RMS Terraform Modules Release Summary </H1>


|       Item                        | Description                                                                   |
| -------------------               | ----------------------------------------------------------------------------- |
| Release Version                   | 1.0.0                                                                           |
| Released by                       | Terraform Module Repository                                            |
| Content Summary                   | Total 8 Azure Terraform modules and documentation |
| Terraform version used            |                                                                          |
| Azure Provider Version used       | v3.33.0                                                                        |
| Total number of base modules      | 8                                                                            |



<H1> Terraform Base Modules </H1>

Base modules are the core modules for Azure resource deployment, which can be reused to create any number of resources in any supported Azure environment.

Following 24 base modules are part of this release :


|SR |   Base Module                 |  Description                                             | 
|-- | -------------------           | -------------------------------------------------------  |
|5  | az-appservice-windows         | Creates Azure windows app services with application slots ,private endpoint , diagonstic settings , app insights and vnet 
|12  | az-functionapp                 | Creates Azure Linux function app with slots ,private endpoint , diagonstic settings and vnet integration for outbound                             |
|13  | az-logicapp                 | Creates Azure logic app workflow with diagonstic settings                            |
|14 | az-logicapp-standard                 | Creates Azure logic app standard with private endpoint , diagonstic settings and vnet integration                            |
|21  | az-serviceplan                 | Creates Azure App service plan                            |
|22  | az-sqlserverdb                 | Creates Azure SQL Server with database , Azure sql elastic pool , auditing policy, security rule , vnet rule and private endpoint                            |
|23  | az-storage-account-container                 | Creates Azure Storage account container                            |
|24  | az-synapse                 | Creates Azure Synapse by enabling data lake with private endpoint and diagonstic settings                            |
