$FindNetworks = Find-AzureRmResource | where {$_.ResourceType -like "Microsoft.Network/VirtualNetworks"}</code>
 
$out = @()
 
Foreach ($Network in $FindNetworks)
{
$Name = $Network.Name
$ResourceType = $Network.ResourceId
$ResourceGroupName = $Network.ResourceGroupName
$Location = $Network.Location
 
$VNetDetail = Get-AzureRmvirtualNetwork -Name $Network.Name -ResourceGroupName $Network.ResourceGroupName
 
$props = @{
 
VNetName = $Network.Name
ResourceGroup = $Network.ResourceGroupName
Location = $Network.Location
AddressSpace = $VNetDetail.AddressSpace.AddressPrefixes
Subnets = $VNetDetail.Subnets
 
}
$out += New-Object PsObject -Property $props
}
$out | Format-Table -AutoSize -Wrap  VNetName, AddressSpace, Subnets, ResourceGroup, Location
$out | Out-GridView -Passthru