param (
    [Parameter(Mandatory=$true)]
    [string] $KeyVaultName,

    [Parameter(Mandatory=$true)]
    [string] $AdminAccountName,

    [Parameter(Mandatory=$true)]
    [string] $TenantId,

    [Parameter(Mandatory=$true)]
    [string] $SubscriptionId,

    [Parameter(Mandatory=$true)]
    [string[]] $MachineNames,

    [Parameter(Mandatory=$true)]
    [string[]] $ResourceGroups
)

$instanceName     = "MSSQLSERVER"

$applicationNames = @()
$certSubjectNames = @()

for ($i = 0; $i -lt $machineNames.Count; $i++) {

    $index = "{0:D2}" -f ($i + 1)

    $applicationNames += "$($machineNames[$i])-SP$index"

    $certSubjectNames += "$($machineNames[$i])-Cert$index"
}

# ============================================================
# CONSTANTS
# ============================================================

$NUMRETRIES = 60

# ============================================================
# VALIDATION
# ============================================================

if ($applicationNames.Count -ne $machineNames.Count `
 -or $machineNames.Count -ne $certSubjectNames.Count `
 -or $machineNames.Count -ne $resourceGroups.Count) {
    Write-Error "Input arrays must have same number of elements"
    exit 1
}

Select-AzSubscription -SubscriptionId $subscriptionId | Out-Null

$keyVault = Get-AzKeyVault -VaultName $keyVaultName -ErrorAction Stop

# ============================================================
# RESOLVE ADMIN ACCOUNT ONCE (ORIGINAL LOGIC)
# ============================================================

$adminAccountType = 0
$adminAccount = Get-AzADUser -UserPrincipalName $adminAccountName -ErrorAction SilentlyContinue

if (-not $adminAccount) {
    $adminAccount = Get-AzADUser -Mail $adminAccountName -ErrorAction SilentlyContinue
    if (-not $adminAccount) {
        $adminAccount = Get-AzADGroup -DisplayName $adminAccountName -ErrorAction SilentlyContinue
        if ($adminAccount) { $adminAccountType = 1 }
    }
}

if (-not $adminAccount) {
    $adminAccount = Get-AzADServicePrincipal -DisplayName $adminAccountName -ErrorAction SilentlyContinue
}

if (-not $adminAccount) {
    Write-Error "Could not find admin account $adminAccountName"
    exit 1
}

$adminAccountSid = $adminAccount.Id

# ============================================================
# MAIN LOOP PER MACHINE
# ============================================================

for ($m=0; $m -lt $machineNames.Count; $m++) {

    $applicationName   = $applicationNames[$m]
    $certSubjectName   = $certSubjectNames[$m]
    $machineName       = $machineNames[$m]
    $resourceGroupName = $resourceGroups[$m]

    Write-Host "`n=== Processing $machineName ===" -ForegroundColor Cyan

    # --------------------------------------------------------
    # CHECK ARC SQL EXTENSION EXISTS
    # --------------------------------------------------------

    $arcInstance = Get-AzConnectedMachineExtension `
        -SubscriptionId $subscriptionId `
        -MachineName $machineName `
        -ResourceGroupName $resourceGroupName `
        -Name "WindowsAgent.SqlServer" `
        -ErrorAction SilentlyContinue

    if (-not $arcInstance) {
        Write-Error "Could not find Arc SQL extension on $machineName"
        continue
    }

    # --------------------------------------------------------
    # CHECK CERTIFICATE DOESN'T EXIST
    # --------------------------------------------------------

    $cert = Get-AzKeyVaultCertificate -VaultName $keyVaultName -Name $certSubjectName -ErrorAction SilentlyContinue
    if ($cert) {
        Write-Error "Certificate $certSubjectName already exists. Skipping $machineName"
        continue
    }

    # --------------------------------------------------------
    # CHECK APP REGISTRATION DOESN'T EXIST
    # --------------------------------------------------------

    $application = Get-AzADApplication -DisplayName $applicationName -ErrorAction SilentlyContinue
    if ($application) {
        Write-Error "Application $applicationName already exists. Skipping $machineName"
        continue
    }

    # --------------------------------------------------------
    # CREATE CERTIFICATE
    # --------------------------------------------------------

    $Policy = New-AzKeyVaultCertificatePolicy `
        -SecretContentType "application/x-pkcs12" `
        -SubjectName "CN=$certSubjectName" `
        -IssuerName "Self" `
        -ValidityInMonths 12 `
        -ReuseKeyOnRenewal

    $addCertRes = Add-AzKeyVaultCertificate -VaultName $keyVaultName -Name $certSubjectName -CertificatePolicy $Policy

    for ($i=0; $i -lt $NUMRETRIES -and (-not $cert -or -not $cert.Enabled); $i++) {
        Start-Sleep -Seconds 5
        $cert = Get-AzKeyVaultCertificate -VaultName $keyVaultName -Name $certSubjectName -ErrorAction SilentlyContinue
    }

    if (-not $cert -or -not $cert.Enabled) {
        Write-Error "Certificate $certSubjectName could not be created. Skipping $machineName"
        continue
    }

    # --------------------------------------------------------
    # ALLOW ARC TO ACCESS KEY VAULT (OLD METHOD)
    # --------------------------------------------------------

    $arcServicePrincipal = Get-AzADServicePrincipal -DisplayName $machineName -ErrorAction SilentlyContinue

    if ($arcServicePrincipal -and $arcServicePrincipal.Id) {
        Set-AzKeyVaultAccessPolicy `
            -VaultName $keyVaultName `
            -ObjectId $arcServicePrincipal.Id `
            -PermissionsToSecrets Get,List `
            -PermissionsToCertificates Get,List `
            -ErrorAction SilentlyContinue
    }
    else {
        Write-Host "Warning: Could not find Arc service principal for $machineName"
    }

    # --------------------------------------------------------
    # CREATE APP REGISTRATION
    # --------------------------------------------------------

    $application = New-AzADApplication -DisplayName $applicationName

    Add-AzADAppPermission -ObjectId $application.Id -ApiId 00000003-0000-0000-c000-000000000000 -PermissionId c79f8feb-a9db-4090-85f9-90d820caa0eb
    Add-AzADAppPermission -ObjectId $application.Id -ApiId 00000003-0000-0000-c000-000000000000 -PermissionId 0e263e50-5827-48a4-b97c-d940288653c7
    Add-AzADAppPermission -ObjectId $application.Id -ApiId 00000003-0000-0000-c000-000000000000 -PermissionId 7ab1d382-f21e-4acd-a863-ba3e13f7da61 -Type Role
    Add-AzADAppPermission -ObjectId $application.Id -ApiId 00000003-0000-0000-c000-000000000000 -PermissionId 5f8c59db-677d-491f-a6b8-5f174b11ec1d
    Add-AzADAppPermission -ObjectId $application.Id -ApiId 00000003-0000-0000-c000-000000000000 -PermissionId a154be20-db9c-4678-8ab7-66f6cc099a59

    $base64Cert = [Convert]::ToBase64String($cert.Certificate.GetRawCertData())

    New-AzADAppCredential `
        -ApplicationObject $application `
        -CertValue $base64Cert `
        -StartDate $cert.Certificate.NotBefore `
        -EndDate $cert.Certificate.NotAfter

    # --------------------------------------------------------
    # CLEAN SECRET ID (ORIGINAL REGEX)
    # --------------------------------------------------------

    $secretId = $cert.SecretId
    if ($secretId -Match "(https:\/\/[^\/]+\/secrets\/[^\/]+)(\/.*){0,1}$") {
        if ($Matches[1]) { $secretId = $Matches[1] }
    }

    # --------------------------------------------------------
    # BUILD INSTANCE SETTINGS
    # --------------------------------------------------------

    $instanceSettings = @{
        instanceName             = $instanceName
        adminLoginName           = $adminAccountName
        adminLoginSid            = $adminAccountSid
        adminLoginType           = $adminAccountType
        azureCertSecretId        = $secretId.Replace(":443","")
        azureCertUri             = $cert.Id.Replace(":443","")
        azureKeyVaultResourceUID = $keyVault.ResourceId
        managedCertSetting       = "SERVICE MANAGED CERT"
        managedAppSetting        = "SERVICE MANAGED APP"
        appRegistrationName      = $application.DisplayName
        appRegistrationSid       = $application.AppId
        tenantId                 = $tenantId
        aadCertSubjectName       = $certSubjectName
    }

    # --------------------------------------------------------
    # MERGE WITH EXISTING AZUREAD SETTINGS (ORIGINAL LOGIC)
    # --------------------------------------------------------

    $arcInstance = Get-AzConnectedMachineExtension `
        -SubscriptionId $subscriptionId `
        -MachineName $machineName `
        -ResourceGroupName $resourceGroupName `
        -Name "WindowsAgent.SqlServer"

    if ($arcInstance.Setting.AdditionalProperties.AzureAD) {

        $aadSettings = $arcInstance.Setting.AdditionalProperties.AzureAD
        $instanceFound = $false
        $instanceIndex = 0
        $instanceNameLower = $instanceName.ToLower()

        for ($i=0; $i -lt $aadSettings.Length; $i++) {
            if ($aadSettings[$i].instanceName.ToLower() -eq $instanceNameLower) {
                $instanceIndex = $i
                $instanceFound = $true
                break
            }
        }

        if ($instanceFound) {
            $aadSettings[$instanceIndex] = $instanceSettings
        }
        else {
            $aadSettings += $instanceSettings
        }
    }
    else {
        $aadSettings = ,$instanceSettings
    }

    # --------------------------------------------------------
    # PUSH SETTINGS TO ARC EXTENSION
    # --------------------------------------------------------

    $SettingsToConfigure = @{ AzureAD = $aadSettings }
    $keys = $arcInstance.Setting.Keys | Where-Object { $_ -notin ("AzureAD") }
    foreach ($key in $keys) {
        $SettingsToConfigure.$key = $arcInstance.Setting["$key"]
    }

    Update-AzConnectedMachineExtension `
        -MachineName $machineName `
        -Name "WindowsAgent.SqlServer" `
        -ResourceGroupName $resourceGroupName `
        -Setting $SettingsToConfigure `
        -ErrorAction Stop

    Write-Host "SUCCESS: Entra ID enabled for $machineName" 
}

Write-Host "`nAll Arc SQL Servers processed successfully." 
