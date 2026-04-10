$galleryName = "testgallery6"
$sourceVM = "testvm"
$resourceGroupName = "testrg"
$location = "Central US"
$imageDefinitionName = "testimage6"
$osType = "Windows"
$osState = "Specialized"
$publisher = "MicrosoftWindowsServer"
$offer = "WindowsServer"
$sku = "Standard_D4s_v3"
# $IsHibernateSupported = @{Name='IsHibernateSupported';Value='True'}
# $IsAcceleratedNetworkSupported = @{Name='IsAcceleratedNetworkSupported';Value='False'}
# $ConfidentialVMSupported = @{Name='SecurityType';Value='ConfidentialVMSupported'}
# $features = @($IsHibernateSupported,$IsAcceleratedNetworkSupported)

$Feature1 = @{Name = 'SecurityType'; Value = 'None' }
$Features = @($Feature1)

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

New-AzGalleryImageVersion `
    -GalleryImageDefinitionName $galleryImage.Name`
    -GalleryImageVersionName '1.0.0' `
    -GalleryName $gallery.Name `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -TargetRegion $targetRegions  `
    -Source $sourceVM.Id.ToString() `
    -PublishingProfileEndOfLifeDate '2030-12-01'