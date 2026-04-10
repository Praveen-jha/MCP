#Define all the required variables
$SqlAdminUser = "sqladmin"
$SqlServerAdminPassword = "password@123"
$ServerName = "sqlvmtestf1"

$FolderName = "AGfolder"
$FolderPath = "C:\$FolderName"
$accountName = 'NT Service\MSSQLSERVER'

$Username = "test"
$UserPassword = "password@123"

$nodeName = "AGNode1"
$certificateName = "AGNode1Cert"

# Create Folder and Give permission to service account on folders
New-Item -ItemType Directory -Path "C:\$FolderName"

$acl = Get-Acl -Path $folderPath

# Grant access to MS SQL Server account on the directory
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    $accountName,
    "FullControl",
    "ContainerInherit,ObjectInherit",
    "None",
    "Allow"
)

$acl.AddAccessRule($accessRule)
Set-Acl -Path $folderPath -AclObject $acl

#Share the folder
New-SmbShare -Name $FolderName -Path $FolderPath -FullAccess "Everyone"


# Create Test User and Add user in Administrator Group

$Password = ConvertTo-SecureString $UserPassword -AsPlainText -Force

# Create local user
New-LocalUser -Name $Username -Password $Password -FullName "Test User" -Description "AG Admin User"

Add-LocalGroupMember -Group "Administrators" -Member $Username


# Add 5022, 1433 port on VM's internal firewall & VM NSG
New-NetFirewallRule -DisplayName "SQL-Port1-Inbound" -Name "SQL-Port1-Inbound" -Protocol TCP -LocalPort 1433 -Direction Inbound -Action Allow
New-NetFirewallRule -DisplayName "SQL-Port2-Inbound" -Name "SQL-Port2-Inbound" -Protocol TCP -LocalPort 5022 -Direction Inbound -Action Allow
New-NetFirewallRule -DisplayName "SQL-Port3-Inbound" -Name "SQL-Port3-Inbound" -Protocol TCP -LocalPort 59999 -Direction Inbound -Action Allow
New-NetFirewallRule -DisplayName "SQL-Port4-Inbound" -Name "SQL-Port4-Inbound" -Protocol TCP -LocalPort 58888 -Direction Inbound -Action Allow

New-NetFirewallRule -DisplayName "SQL-Port1-Outbound" -Name "SQL-Port1-Outbound" -Protocol TCP -LocalPort 1433 -Direction Outbound -Action Allow
New-NetFirewallRule -DisplayName "SQL-Port2-Outbound" -Name "SQL-Port2-Outbound" -Protocol TCP -LocalPort 5022 -Direction Outbound -Action Allow
New-NetFirewallRule -DisplayName "SQL-Port3-Outbound" -Name "SQL-Port3-Outbound" -Protocol TCP -LocalPort 59999 -Direction Outbound -Action Allow
New-NetFirewallRule -DisplayName "SQL-Port4-Outbound" -Name "SQL-Port4-Outbound" -Protocol TCP -LocalPort 58888 -Direction Outbound -Action Allow

# Install Failover Cluster Features and Tools
Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools

#Create certificate
$createCertificate = @"
USE master;   
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'PassWOrd123!';   
GO 
--create a cert from the master key 
USE master;   
CREATE CERTIFICATE $certificateName    
  WITH SUBJECT = '$nodeName Certificate';   
GO   
--Backup the cert and transfer it to AGNode2 
BACKUP CERTIFICATE $certificateName TO FILE = 'C:\$FolderName\$certificateName.crt';   
GO 
"@

# Execute the SQL commands
sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createCertificate 

#Create mirroring endpoint
$createMirroringEndpoint = @"
CREATE ENDPOINT hadr_endpoint   
   STATE = STARTED   
   AS TCP (   
      LISTENER_PORT=5022   
      , LISTENER_IP = ALL   
   )    
   FOR DATABASE_MIRRORING (    
      AUTHENTICATION = CERTIFICATE $certificateName   
      , ENCRYPTION = REQUIRED ALGORITHM AES   
      , ROLE = ALL   
   );   
GO 
"@

sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createMirroringEndpoint
