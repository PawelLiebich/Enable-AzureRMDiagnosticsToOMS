# Enable-AzureRMDiagnosticsToOMS
Enabling Azure Diagnostic items in resource group to Log Analytics/OMS. There is also version for Azure Automation.



# Enabling
Network Security Groups
Virtual Machines
Network Interfaces
Virtual Networks
Databases
Elasticpools
Key Vaults


# How To
$OPSSubscriptionId = Subscription Id where is Log Analytics/OMS
$OPSName = Name of of Analytics/OMS
$OPSResourceGroup = Resource group of Log Analytics/OMS

$SubscriptionId = Subscription Id where are resources
$ResourceGroup = resource group where are placed items


# How To Automation

Create Automation Variable:
OPSSubscriptionId
OPSName
OPSResourceGroup
SubscriptionId
ResourceGroup

Create Automation Credentials:
Admin
