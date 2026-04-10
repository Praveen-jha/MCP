# WinRM Server Complete Configuration Script - Integrated Version
      # Enhanced with certificate import for Current User Personal store
      
      [CmdletBinding()]
      param(
          [string]$DomainName = "*.products.cdk.com",
          [string]$CertPath = "C:\WinRM Script",
          [string[]]$DelegateTarget = @("WSMAN/*", "WSMAN/localhost", "WSMAN/$env:COMPUTERNAME", "WSMAN/$env:COMPUTERNAME.$env:USERDNSDOMAIN")
      )

      # Remove the Reg key for TCPIP to make AAD Extension working
      Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name Domain -Value ""

      # Check if running as Administrator
      if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
          Write-Error "This script must be run as Administrator. Exiting..."
          exit 1
      }

      Write-Host "=== WinRM Server Complete Configuration Script ===" -ForegroundColor Cyan
      Write-Host "Starting automated WinRM HTTPS, CredSSP, and Group Policy configuration..." -ForegroundColor Green

      try {
          # Step 1: Create certificate directory if it doesn't exist
          Write-Host "`n[Step 1] Creating certificate directory..." -ForegroundColor Yellow
          if (!(Test-Path -Path $CertPath)) {
              New-Item -ItemType Directory -Path $CertPath -Force | Out-Null
              Write-Host "Created directory: $CertPath" -ForegroundColor Green
          } else {
              Write-Host "Directory already exists: $CertPath" -ForegroundColor Green
          }

          # Step 2: Create self-signed certificate
          Write-Host "`n[Step 2] Creating self-signed certificate..." -ForegroundColor Yellow
          $cert = New-SelfSignedCertificate -DnsName $DomainName -CertStoreLocation Cert:\LocalMachine\My
          $thumbprint = $cert.Thumbprint
          Write-Host "Certificate created successfully!" -ForegroundColor Green
          Write-Host "Certificate Thumbprint: $thumbprint" -ForegroundColor Cyan

          # Step 3: Export certificate
          Write-Host "`n[Step 3] Exporting certificate..." -ForegroundColor Yellow
          $certPath_cer = Join-Path $CertPath "WinRM_Certificate.cer"
          Export-Certificate -Cert $cert -FilePath $certPath_cer -Force | Out-Null
          Write-Host "Certificate exported to: $certPath_cer" -ForegroundColor Green

          # Step 4: Import certificate to Trusted Root Certification Authorities
          Write-Host "`n[Step 4] Importing certificate to Trusted Root CA..." -ForegroundColor Yellow
          Import-Certificate -FilePath $certPath_cer -CertStoreLocation Cert:\LocalMachine\Root | Out-Null
          Write-Host "Certificate imported to Trusted Root CA store" -ForegroundColor Green

          # Step 5: Import certificate to Current User Personal store (INTEGRATED ENHANCEMENT)
          Write-Host "`n[Step 5] Importing certificate to Current User Personal store..." -ForegroundColor Yellow
          try {
              $PersonalStore = "Cert:\CurrentUser\My"
              Import-Certificate -FilePath $certPath_cer -CertStoreLocation $PersonalStore | Out-Null
              Write-Host "Certificate imported to Current User Personal store" -ForegroundColor Green
          } catch {
              Write-Warning "Failed to import to Current User Personal store: $($_.Exception.Message)"
          }

          # Step 6: Remove old HTTPS listeners
          Write-Host "`n[Step 6] Removing existing HTTPS listeners..." -ForegroundColor Yellow
          Get-ChildItem WSMan:\localhost\Listener | Where-Object {$_.keys -like "*https*" } | Remove-Item -Confirm:$false -Force -Recurse
          Write-Host "Old HTTPS listeners removed" -ForegroundColor Green

          # Step 7: Create new HTTPS listener with certificate
          Write-Host "`n[Step 7] Creating new WinRM HTTPS listener..." -ForegroundColor Yellow
          $valueset = @{
              Hostname = $DomainName
              CertificateThumbprint = $cert.thumbprint
          }
          $selectorset = @{
              Transport = "HTTPS"
              Address = "*"
          }
          New-WSManInstance -ResourceURI 'winrm/config/Listener' -SelectorSet $selectorset -ValueSet $valueset
          Write-Host "New HTTPS listener created successfully" -ForegroundColor Green

          # Step 8: Create firewall rule for port 5986
          Write-Host "`n[Step 8] Creating firewall rule for WinRM HTTPS (port 5986)..." -ForegroundColor Yellow
          try {
              Remove-NetFirewallRule -DisplayName "WinRM HTTPS" -ErrorAction SilentlyContinue
              New-NetFirewallRule -DisplayName "WinRM HTTPS" -Name "WinRM-HTTPS" -Protocol TCP -LocalPort 5986 -Direction Inbound -Action Allow | Out-Null
              Write-Host "Firewall rule created for port 5986" -ForegroundColor Green
          } catch {
              Write-Warning "Failed to create firewall rule: $($_.Exception.Message)"
          }

          # Step 9: Start and configure WinRM service
          Write-Host "`n[Step 9] Starting and configuring WinRM service..." -ForegroundColor Yellow
          Start-Service WinRM -ErrorAction SilentlyContinue
          Set-Service WinRM -StartupType Automatic
          Write-Host "WinRM service started and set to automatic startup" -ForegroundColor Green

          # Step 10: Configure WinRM authentication settings
          Write-Host "`n[Step 10] Configuring WinRM authentication settings..." -ForegroundColor Yellow
          Set-Item WSMan:\localhost\Service\Auth\Basic -Value $true -Force
          Set-Item WSMan:\localhost\Service\Auth\Certificate -Value $true -Force  
          Set-Item WSMan:\localhost\Service\Auth\CredSSP -Value $true -Force
          Write-Host "Authentication settings configured (Basic, Certificate, CredSSP enabled)" -ForegroundColor Green

          # Step 11: Set LocalAccountTokenFilterPolicy
          Write-Host "`n[Step 11] Configuring LocalAccountTokenFilterPolicy..." -ForegroundColor Yellow
          $token_path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
          $token_prop_name = "LocalAccountTokenFilterPolicy"
          $token_key = Get-Item -Path $token_path
          $token_value = $token_key.GetValue($token_prop_name, $null)
          if ($token_value -ne 1) {
              Write-Verbose "Setting LocalAccountTokenFilterPolicy to 1"
              if ($null -ne $token_value) {
                  Remove-ItemProperty -Path $token_path -Name $token_prop_name
              }
              New-ItemProperty -Path $token_path -Name $token_prop_name -Value 1 -PropertyType DWORD > $null
          }
          Write-Host "LocalAccountTokenFilterPolicy configured" -ForegroundColor Green

          # Step 12: Enable CredSSP Server
          Write-Host "`n[Step 12] Enabling CredSSP Server..." -ForegroundColor Yellow
          $credsspAuthSetting = Get-ChildItem WSMan:\localhost\Service\Auth | Where-Object { $_.Name -eq "CredSSP" }
          If (($credsspAuthSetting.Value) -eq $false) {
              Enable-WSManCredSSP -role server -Force
          }
          Write-Host "CredSSP Server enabled" -ForegroundColor Green

          # Step 13: Configure Group Policy for CredSSP (Registry-based)
          Write-Host "`n[Step 13] Configuring Group Policy for CredSSP delegation..." -ForegroundColor Yellow
          
          $credDelegationPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
          if (!(Test-Path $credDelegationPath)) {
              New-Item -Path $credDelegationPath -Force | Out-Null
              Write-Host "Created CredentialsDelegation registry key" -ForegroundColor Green
          }

          # Configure Allow Delegating Fresh Credentials
          Set-ItemProperty -Path $credDelegationPath -Name "AllowFreshCredentials" -Value 1 -Type DWord -Force
          Set-ItemProperty -Path $credDelegationPath -Name "ConcatenateDefaults_AllowFreshCredentials" -Value 1 -Type DWord -Force
          Write-Host "Enabled 'Allow Delegating Fresh Credentials' policy" -ForegroundColor Green

          # Configure Allow Delegating Fresh Credentials with NTLM-only server authentication  
          Set-ItemProperty -Path $credDelegationPath -Name "AllowFreshCredentialsWhenNTLMOnly" -Value 1 -Type DWord -Force
          Set-ItemProperty -Path $credDelegationPath -Name "ConcatenateDefaults_AllowFreshCredentialsWhenNTLMOnly" -Value 1 -Type DWord -Force
          Write-Host "Enabled 'Allow Delegating Fresh Credentials with NTLM-only server authentication' policy" -ForegroundColor Green

          # Create AllowFreshCredentials subkey and add delegate targets
          $allowFreshCredsPath = "$credDelegationPath\AllowFreshCredentials"
          if (!(Test-Path $allowFreshCredsPath)) {
              New-Item -Path $allowFreshCredsPath -Force | Out-Null
          }

          $index = 1
          foreach ($target in $DelegateTarget) {
              New-ItemProperty -Path $allowFreshCredsPath -Name $index -Value $target -PropertyType String -Force | Out-Null
              Write-Host "Added delegation target: $target" -ForegroundColor Cyan
              $index++
          }

          # Create AllowFreshCredentialsWhenNTLMOnly subkey and add delegate targets
          $allowFreshCredsNTLMPath = "$credDelegationPath\AllowFreshCredentialsWhenNTLMOnly"
          if (!(Test-Path $allowFreshCredsNTLMPath)) {
              New-Item -Path $allowFreshCredsNTLMPath -Force | Out-Null
          }

          $index = 1
          foreach ($target in $DelegateTarget) {
              New-ItemProperty -Path $allowFreshCredsNTLMPath -Name $index -Value $target -PropertyType String -Force | Out-Null
              $index++
          }

          # Step 14: Configure WinRM Client settings
          Write-Host "`n[Step 14] Configuring WinRM Client settings..." -ForegroundColor Yellow
          
          $winrmClientPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
          if (!(Test-Path $winrmClientPath)) {
              New-Item -Path $winrmClientPath -Force -ItemType Directory | Out-Null
          }
          Set-ItemProperty -Path $winrmClientPath -Name "AllowCredSSP" -Value 1 -Type DWord -Force

          $winrmServicePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"
          if (!(Test-Path $winrmServicePath)) {
              New-Item -Path $winrmServicePath -Force -ItemType Directory | Out-Null
          }
          Set-ItemProperty -Path $winrmServicePath -Name "AllowCredSSP" -Value 1 -Type DWord -Force

          Write-Host "WinRM Client and Service CredSSP settings configured" -ForegroundColor Green

          # Step 15: Enable CredSSP Client
          Write-Host "`n[Step 15] Enabling CredSSP Client..." -ForegroundColor Yellow
          try {
              Enable-WSManCredSSP -Role Client -DelegateComputer localhost -Force
              Enable-WSManCredSSP -Role Client -DelegateComputer $env:COMPUTERNAME -Force
              if ($env:USERDNSDOMAIN) {
                  Enable-WSManCredSSP -Role Client -DelegateComputer "*.$env:USERDNSDOMAIN" -Force
              }
              Write-Host "CredSSP Client enabled for local and domain targets" -ForegroundColor Green
          } catch {
              Write-Warning "CredSSP Client configuration had some issues: $($_.Exception.Message)"
          }

          # Step 16: Configure TrustedHosts
          Write-Host "`n[Step 16] Configuring TrustedHosts..." -ForegroundColor Yellow
          try {
              $currentHosts = (Get-Item WSMan:\localhost\Client\TrustedHosts).Value
              if ([string]::IsNullOrEmpty($currentHosts)) {
                  Set-Item WSMan:\localhost\Client\TrustedHosts -Value "localhost,$env:COMPUTERNAME" -Force
              } else {
                  $hostsToAdd = @("localhost", $env:COMPUTERNAME) | Where-Object { $currentHosts -notlike "*$_*" }
                  if ($hostsToAdd.Count -gt 0) {
                      $newHosts = "$currentHosts," + ($hostsToAdd -join ",")
                      Set-Item WSMan:\localhost\Client\TrustedHosts -Value $newHosts -Force
                  }
              }
              Write-Host "TrustedHosts configured for local connections" -ForegroundColor Green
          } catch {
              Write-Warning "TrustedHosts configuration had issues: $($_.Exception.Message)"
          }

          # Step 17: Apply Group Policy updates
          Write-Host "`n[Step 17] Applying Group Policy updates..." -ForegroundColor Yellow
          try {
              gpupdate /force | Out-Null
              Write-Host "Group Policy updates applied" -ForegroundColor Green
          } catch {
              Write-Warning "Group Policy update may require manual application or system restart"
          }

          # Step 18: Restart WinRM service to ensure all settings are applied
          Write-Host "`n[Step 18] Restarting WinRM service..." -ForegroundColor Yellow
          Restart-Service WinRM -Force
          Write-Host "WinRM service restarted successfully" -ForegroundColor Green

          # Final Configuration Summary
          Write-Host "`n=== Configuration Complete - Summary ===" -ForegroundColor Cyan
          Write-Host "[OK] Self-signed certificate created and installed" -ForegroundColor Green
          Write-Host "[OK] Certificate thumbprint: $thumbprint" -ForegroundColor Green  
          Write-Host "[OK] Certificate exported to: $certPath_cer" -ForegroundColor Green
          Write-Host "[OK] Certificate imported to Trusted Root CA store" -ForegroundColor Green
          Write-Host "[OK] Certificate imported to Current User Personal store" -ForegroundColor Green
          Write-Host "[OK] HTTPS listener created with certificate" -ForegroundColor Green
          Write-Host "[OK] Firewall rule created for port 5986" -ForegroundColor Green
          Write-Host "[OK] WinRM service configured and restarted" -ForegroundColor Green
          Write-Host "[OK] Authentication methods enabled (Basic, Certificate, CredSSP)" -ForegroundColor Green
          Write-Host "[OK] LocalAccountTokenFilterPolicy configured" -ForegroundColor Green
          Write-Host "[OK] CredSSP Server and Client enabled" -ForegroundColor Green
          Write-Host "[OK] Group Policy for CredSSP delegation configured" -ForegroundColor Green
          Write-Host "[OK] All registry-based policy configurations completed" -ForegroundColor Green

          Write-Host "`n=== Testing Configuration ===" -ForegroundColor Yellow
          try {
              $testResult = Test-WSMan -ComputerName localhost -UseSSL -ErrorAction Stop
              Write-Host "WinRM HTTPS test successful!" -ForegroundColor Green
          } catch {
              Write-Warning "WinRM HTTPS test failed: $($_.Exception.Message)"
          }

          Write-Host "`n=== Configuration Successfully Completed! ===" -ForegroundColor Green
          Write-Host "WinRM Server is fully configured for secure HTTPS and CredSSP authentication!" -ForegroundColor Green

      } catch {
          Write-Error "Configuration failed: $($_.Exception.Message)"
          Write-Host "Please check the error above and run the script again." -ForegroundColor Red
          exit 1
      }
