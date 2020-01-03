$FindVMs = Find-AzureRmResource | where {$_.ResourceType -like "Microsoft.Compute/virtualMachines"}
  
$out = @()
  
Foreach ($vm in $Findvms)
{
$Name = $VM.Name
$ResourceId = $VM.ResourceId
$ResourceGroupName = $VM.ResourceGroupName
$Location = $VM.Location
  
$VMDetail = Get-AzureRmVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name -Status
$props = @{
  
VMName = $VM.Name
ResourceGroup = $VM.ResourceGroupName
Location = $VM.Location
PowerState = $VMDetail.Statuses[1].DisplayStatus
}
$out += New-Object PsObject -Property $props
}
$out | Format-Table -AutoSize -Wrap  ResourceGroup, Location, VMName,Powerstate
$out | Out-GridView -Passthru