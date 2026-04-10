#Remove the Reg key we added for TCPIP to make AAD Extenstion working
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name Domain -Value ""

# Create cert with domain name
$cert = New-SelfSignedCertificate -DnsName "*.products.cdk.com" -CertStoreLocation Cert:\LocalMachine\My

# Remove old HTTPS listener
Get-ChildItem WSMan:\localhost\Listener  | ? {$_.keys -like "*https*" } |  remove-item -Confirm:$false -Force -Recurse

# Prep for new listener
$valueset = @{
    Hostname = "*.products.cdk.com"
    CertificateThumbprint = $cert.thumbprint
}
$selectorset = @{
    Transport = "HTTPS"
    Address = "*"
}

# Create new listener
New-WSManInstance -ResourceURI 'winrm/config/Listener' -SelectorSet $selectorset -ValueSet $valueset

# Set Registry Key
$token_path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$token_prop_name = "LocalAccountTokenFilterPolicy"
$token_key = Get-Item -Path $token_path
$token_value = $token_key.GetValue($token_prop_name, $null)
if ($token_value -ne 1) {
    Write-Verbose "Setting LocalAccountTOkenFilterPolicy to 1"
    if ($null -ne $token_value) {
        Remove-ItemProperty -Path $token_path -Name $token_prop_name
    }
    New-ItemProperty -Path $token_path -Name $token_prop_name -Value 1 -PropertyType DWORD > $null
}

# Enable Cred SSP
$credsspAuthSetting = Get-ChildItem WSMan:\localhost\Service\Auth | Where-Object { $_.Name -eq "CredSSP" }
If (($credsspAuthSetting.Value) -eq $false) {
 Enable-WSManCredSSP -role server -Force
}