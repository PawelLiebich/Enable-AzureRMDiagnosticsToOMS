Write-Output "Start"
Write-Output "Logging in to Azure"
Login-AzureRmAccount
########################################
$OPSSubscriptionId = '5555555-555-5555-555-5555555'
$OPSName = 'DefaultWorkspace-55555-55555-555-555-55555-WEU'
$OPSResourceGroup = 'defaultresourcegroup-weu'
########################################
$SubscriptionId = '5555555-555-5555-555-5555555'
$ResourceGroup = '55555-55-dev'
########################################
$WSID = ("/subscriptions/" + $OPSSubscriptionId + "/resourceGroups/" + $OPSResourceGroup + "/providers/Microsoft.OperationalInsights/workspaces/" + $OPSName)
Set-AzureRmContext -SubscriptionId $SubscriptionId
[array]$ResourceTypes = "Microsoft.Network/networkSecurityGroups", "Microsoft.Compute/virtualMachines", "Microsoft.Network/networkInterfaces", "Microsoft.KeyVault/vaultsMicrosoft.Sql/servers", "Microsoft.Network/virtualNetworks", "microsoft.sql/servers/databases", "Microsoft.Sql/servers/elasticpools", "Microsoft.KeyVault/vaults"
###########################################################
Write-Output "Adding to OMS:" $OPSName
foreach ($ResourceType in $ResourceTypes)
{
    Write-Output "Type:" $ResourceType
    $Resources = Find-AzureRmResource -ResourceGroupName $ResourceGroup -ResourceType $ResourceType
    foreach ($Resource in $Resources)
    {
        Set-AzureRmDiagnosticSetting -ResourceId $Resource.ResourceId -WorkspaceId $WSID -Enabled $True | Out-Null
        Write-Output "Added:" $Resource.Name
    }
    Write-Output "Done for type:" $ResourceType
}
Write-Output "Script done"



