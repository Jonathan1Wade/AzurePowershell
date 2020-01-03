Add-AzureAccount
$services = Get-AzureVM | Group-Object -Property ServiceName
foreach ($service in $services)
{
   $out = @()
foreach ($VM in $service.Group)
{ 
$VMSizes = $VM.InstanceSize 
 
    $props = @{
        Cloudservice = $service.Name        
        VMName = $VM.Name
        VMSizes = $VMSizes
        }
     
    $out += New-Object PsObject -Property $props
}
   $out | Format-Table -AutoSize -Wrap CloudService, VMName, VMSizes
   $out | Export-Csv c:\scripts\test.csv -append
} 