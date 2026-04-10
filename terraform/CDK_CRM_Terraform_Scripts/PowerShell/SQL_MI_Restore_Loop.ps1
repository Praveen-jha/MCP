# Variables
$ResourceGroupName = "rg-mr-crm-dev-cus-reports001"
$StrResourceGroupName = "rg-mr-crm-dev-cus-devcusbackuprestore01"
$InstanceName = "mssql-mr-crm-dev-cus-reports001"
$Collation = "SQL_Latin1_General_CP1_CI_AS"

$StorageAccountName = "devcusbackuprestore01"
$ContainerName = "scontainer-mr-crm-dev-cus-devcusbackuprestore01"
$FolderName = "REPORTS01"
$SubFolder1Name = "Full"
$SubFolder2Name = "AG"

$BaseBlobPath = "$FolderName/$SubFolder1Name/$SubFolder2Name/"

$StorageAccount = Get-AzStorageAccount -ResourceGroupName $StrResourceGroupName -Name $StorageAccountName -ErrorAction Stop
$StorageContext = $StorageAccount.Context

$SasTokenExpiry = (Get-Date).AddHours(8)
$SasPermissions = "racwdl"

$SasToken = New-AzStorageContainerSASToken -Name $ContainerName -Context $StorageContext -Permission $SasPermissions -ExpiryTime $SasTokenExpiry

Write-Host "DEBUG: SasToken generated: '$($SasToken)'"

if ([string]::IsNullOrEmpty($SasToken)) {
    throw "Failed to generate SAS token for container '$ContainerName'."
}
Write-Host "SAS Token generated successfully (valid until $SasTokenExpiry) with permissions: '$SasPermissions'."

$allBlobs = Get-AzStorageBlob -Container $ContainerName -Prefix $BaseBlobPath -Context $StorageContext

$databaseFolders = $allBlobs.Name |
    ForEach-Object {
        $_.Substring($BaseBlobPath.Length).Split('/')[0]
    } |
    Where-Object { $_ -ne "" } |
    Select-Object -Unique

foreach ($DatabaseName in $databaseFolders) {

        $dbFolderPrefix = "$BaseBlobPath$DatabaseName/"

        $backupFiles = Get-AzStorageBlob -Container $ContainerName -Prefix $dbFolderPrefix -Context $StorageContext |
                   Where-Object { $_.Name -like "*.bak" } |
                   Sort-Object -Property LastModified -Descending

        if (-not $backupFiles) {
        Write-Warning "  No .bak files found in database folder: '$DatabaseName'. Skipping."
        continue
        }

        $LatestBackupFile = $backupFiles | Select-Object -First 1
        $LastBackupName = $LatestBackupFile.Name.Split('/')[-1]
        $CurrentStorageContainerUri = "https://$StorageAccountName.blob.core.windows.net/$ContainerName/$dbFolderPrefix" 

        Write-Host "  Found latest backup file: '$LastBackupName' (LastModified: $($LatestBackupFile.LastModified))"
        Write-Host "  Storage Container URI for restore target: '$CurrentStorageContainerUri'"

        # --- Step 3: Start the Restore Operation ---
        Write-Host "  Starting restore for database '$DatabaseName' on instance '$InstanceName'..."
            Start-AzSqlInstanceDatabaseLogReplay `
                -ResourceGroupName $ResourceGroupName `
                -InstanceName $InstanceName `
                -Name $DatabaseName `
                -StorageContainerUri $CurrentStorageContainerUri `
                -StorageContainerSasToken $SasToken `
                -AutoCompleteRestore `
                -LastBackupName $LastBackupName `
                -Verbose # Show detailed output of the restore command

        Write-Host "  Restore command submitted successfully for database '$DatabaseName' from '$LastBackupName'."
}
