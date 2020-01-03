# New-AzurePublicRmIAddress creates the new IP - Run this first.
 
new-azurermpublicIPAddress -Name testip -ResourceGroupName wpbackup -AllocationMethod Static -Location "Southeast Asia"
 
# Set the variables but getting the properties you need
$nic = Get-AzurermNetworkInterface -ResourceGroupName Nameof ResourceGroup -Name NameofNIC
$pip = Get-AzurermPublicIPAddress -ResourceGroupName wpbackup -Name testip
$nic.IPConfigurations[0].PublicIPAddress=$pip
 
# Finally set the IP address against the NIC
Set-AzureRmNetworkInterface -NetworkInterface $nic