#Networking
$NicName = $vmName + "NIC-Prod"
$Vnet = Get-AzureRmVirtualNetwork -Name "hubsydvnet" -ResourceGroupName $RGName
$SubnetProduction = Get-AzureRmVirtualNetworkSubnetConfig -Name "Sub-1" -VirtualNetwork $Vnet
$Nic = New-AzureRmNetworkInterface -ResourceGroupName $RGName -Name $NicName -Subnet $SubnetProduction -Location $Location
 
#Define VM Configuration
$VMConfig = New-AzureRmVMConfig -VMName $vmName -VMSize "Standard_DS2_v2" |
Set-AzureRmVMOperatingSystem -Windows -ComputerName $vmName -Credential $Cred -ProvisionVMAgent -EnableAutoUpdate |
Set-AzureRmVMOSDisk -Name $OSDiskName -VhdUri $OSDiskUri -CreateOption FromImage -SourceImageUri $URIofuploadedImage -Windows |
Add-AzureRmVMNetworkInterface -Id $Nic.ID -Primary