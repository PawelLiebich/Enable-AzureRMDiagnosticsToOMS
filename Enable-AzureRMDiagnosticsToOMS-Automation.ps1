Write-Output "Start"
Write-Output "Logging in to Azure"
$login = Get-AutomationPSCredential -Name 'Admin'
Login-AzureRmAccount -Credential $login
########################################
$OPSSubscriptionId = Get-AutomationVariable -Name 'OPSSubscriptionId'
$OPSName = Get-AutomationVariable -Name 'OPSName'
$OPSResourceGroup = Get-AutomationVariable -Name 'OPSResourceGroup'
########################################
$SubscriptionId = Get-AutomationVariable -Name 'SubscriptionId'
$ResourceGroup = Get-AutomationVariable -Name 'ResourceGroup'
########################################
$WSID = ("/subscriptions/" + $OPSSubscriptionId + "/resourceGroups/" + $OPSResourceGroup + "/providers/Microsoft.OperationalInsights/workspaces/" + $OPSName)
Set-AzureRmContext -SubscriptionId $SubscriptionId
[array]$ResourceTypes = "Microsoft.Network/networkSecurityGroups", "Microsoft.Compute/virtualMachines", "Microsoft.Network/networkInterfaces", "Microsoft.Network/virtualNetworks", "microsoft.sql/servers/databases", "Microsoft.Sql/servers/elasticpools", "Microsoft.KeyVault/vaults"
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





