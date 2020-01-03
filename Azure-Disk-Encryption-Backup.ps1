subscriptionName = "SUBSCRIPTION NAME"
 
$RGName = "RESOURCE GROUP NAME"
 
$VMName = "VM NAME"
 
$AADClientID = "AZURE AD APPLICATION ID"
 
$AADClientSecret = "AZURE AD APPLICATION SECRET"
 
$VaultName= "KEY VAULT NAME"
 
$keyName = "KEY NAME"
 
$keyEncryptionKeyUri = Get-AzureKeyVaultKey -VaultName $VaultName -KeyName $keyName
 
$KeyVault = Get-AzureRmKeyVault -VaultName $VaultName -ResourceGroupName $RGName
 
$DiskEncryptionKeyVaultUrl = $KeyVault.VaultUri
 
$KeyVaultResourceId = $KeyVault.ResourceId
 
Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName $RGName -VMName $vmName -
 
AadClientID $AADClientID -AadClientSecret $AADClientSecret -
 
DiskEncryptionKeyVaultUrl $DiskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId
 
$KeyVaultResourceId -KeyEncryptionKeyUrl $keyEncryptionKeyUri.Id -
 
KeyEncryptionKeyVaultId $keyVaultResourceId