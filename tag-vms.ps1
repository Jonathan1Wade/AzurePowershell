$FindVMs = Find-AzureRmResource | where {$_.ResourceType -like "Microsoft.Compute/virtualMachines"}
$Tags = (Get-AzureRmResource -ResourceId $ResourceId).Tags
$Tags += @{ Owner = "wade" }
 
Foreach ($vm in $Findvms)
{
$ResourceId = $VM.ResourceId
Set-AzureRmResource -Tag $Tags -ResourceId $ResourceId -Force
}