$galleryName = "testgallery6"
$sourceVM = "testvm2"
$resourceGroupName = "sql-vm-rg"
$location = "Central US"
$imageDefinitionName = "testimage6"
$osType = "Windows"
$osState = "Generalized"
$publisher = "microsoftsqlserver"
$offer = "sql2022-ws2022"
$sku = "sqldev-gen2"
# $IsHibernateSupported = @{Name='IsHibernateSupported';Value='True'}
# $IsAcceleratedNetworkSupported = @{Name='IsAcceleratedNetworkSupported';Value='False'}
# $ConfidentialVMSupported = @{Name='SecurityType';Value='ConfidentialVMSupported'}
# $features = @($IsHibernateSupported,$IsAcceleratedNetworkSupported)
 
#$Feature1 = @{Name = 'SecurityType'; Value = 'None' }
#$Feature2 = @({Name = 'DiskControllerTypes'; Value = 'SCSI,NVMe'})
#$Features = @($Feature1)
#$Features = @($Feature1)
 
$Features = @(
    @{Name = 'SecurityType'; Value = 'None' },
    @{Name = 'DiskControllerTypes'; Value = 'SCSI,NVMe'}
)
 
$sourceVM = Get-AzVM `
    -Name $sourceVM `
    -ResourceGroupName $resourceGroupName
 
$gallery = New-AzGallery `
    -GalleryName $galleryName `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -Description 'Azure Compute Gallery for my organization'	
 
$galleryImage = New-AzGalleryImageDefinition -GalleryName $galleryName `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -Name $imageDefinitionName `
    -OsType $osType `
    -OsState $osState `
    -Publisher $publisher `
    -Offer $offer `
    -Sku $sku `
    -Feature $Features `
    -HyperVGeneration "V2"
 
$region1 = @{Name = 'Central US'; ReplicaCount = 1 }
$region2 = @{Name = 'East US'; ReplicaCount = 2 }
$targetRegions = @($region1, $region2)
 
Set-AzVm -ResourceGroupName $resourceGroupName -Name $sourceVM -Generalized
 
New-AzGalleryImageVersion `
    -GalleryImageDefinitionName $galleryImage.Name`
    -GalleryImageVersionName '1.0.1' `
    -GalleryName $gallery.Name `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -TargetRegion $targetRegions  `
    -Source $sourceVM.Id.ToString() `
    -PublishingProfileEndOfLifeDate '2030-12-01'