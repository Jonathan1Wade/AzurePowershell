# Original script came from the very accomplished John Savill and was posted at Windows IT Pro.

$FindStorage = Get-AzurermStorageAccount
$out = @()
 
Foreach ($Storage in $FindStorage)
{
$Name = $Storage.StorageAccountName
$ResourceGroupName = $Storage.ResourceGroupName
$Location = $Storage.Location
 
$AllBlobs = Get-AzureRMStorageAccount -Name $Name -ResourceGroupName $ResourceGroupName |
    Get-AzureStorageContainer | where {$_.Name -eq 'vhds'} | Get-AzureStorageBlob | where {$_.Name.EndsWith('.vhd')}
 
$VHDsinAct = 0
 
foreach ($Blob in $AllBlobs)
{
 
    if($Blob.ICloudBlob.Properties.LeaseState -eq 'Leased' -and $Blob.ICloudBlob.Properties.LeaseDuration -eq 'Infinite')
    {
        $VHDsinAct++
    }
}
 
$props = @{
 
StorageAccount = $Name
VHDs = $VHDsinAct
ResourceGroup = $ResourceGroupName
Location =$Location
}
#Write-Output "Total of $VHDsinAct VHDs in $Name"
$out += New-Object PsObject -Property $props
}
 
$out | Format-Table -AutoSize -Wrap  StorageAccount, VHDs, ResourceGroup, Location
$out | Out-GridView -Passthru