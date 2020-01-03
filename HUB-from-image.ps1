#login into azure and select the right subscription
Login-AzureRmAccount
Get-AzureRmSubscription
Select-AzureRmSubscription
 
#upload HUB file
$RGName = "Resource Group Name"
    $urlOfUploadedImageVhd = "https://storageaccountname.blob.core.windows.net/container/imagename.vhd"
    Add-AzureRmVhd -ResourceGroupName $rgName -Destination $urlOfUploadedImageVhd -LocalFilePath "C:\Source\imagename.vhd"
 
#Create VM using image
$Cred = Get-Credential #Don't forget needs to be complex
$vmName = "Name of VM"
$StorageAccount = Get-AzureRmStorageAccount -ResourceGroupName $RGName -name "Resource Group Name"
$OSDiskName = "$vmName-C-01"
$nicname = "Nic01-$vmName-Prod"
$OSDiskUri = $StorageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $OSDiskName + ".vhd" #Name & path of new VHD
$URIofuploadedImage = $StorageAccount.PrimaryEndpoints.Blob.ToString() + "image container/image.vhd" #location of template VHD
$Location= "Azure location"
 
#Networking 
$Vnet = Get-AzureRmVirtualNetwork -Name "Virtual Network Name" -ResourceGroupName $RGName
$SubnetProduction = Get-AzureRmVirtualNetworkSubnetConfig -Name "Sub-1" -VirtualNetwork $Vnet
$Nic = New-AzureRmNetworkInterface -ResourceGroupName $RGName -Name $Nicname -Subnet $SubnetProduction -Location $Location
 
#Define VM Configuration
$VMConfig = New-AzureRmVMConfig -VMName $vmName -VMSize "Standard_DS2" |
    Set-AzureRmVMOperatingSystem -Windows -ComputerName $vmName -Credential $Cred -ProvisionVMAgent -EnableAutoUpdate |
    Set-AzureRmVMOSDisk -Name $OSDiskName -VhdUri $OSDiskUri -CreateOption FromImage -SourceImageUri $URIofuploadedImage -Windows |
    Add-AzureRmVMNetworkInterface -Id $Nic.ID -Primary
 
#Create VM
New-AzureRmVM -ResourceGroupName $RGName -Location $Location -LicenseType "Windows_Server" -VM $VMConfig
 
#Check license type of new VM
Get-AzureRmVM -ResourceGroupName $RGName -Name $vmName | Format-Table -AutoSize Name, LicenseType, Location, ProvisioningState