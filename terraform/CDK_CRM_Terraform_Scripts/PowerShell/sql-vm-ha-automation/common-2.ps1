#Define all the required variables
$ServerName = "sqlvmtesti1"
$SqlAdminUser = "sqladmin"
$SqlServerAdminPassword = "password@123"

$nodeName1 = "AGNode2"
$certificateName1 = "AGNode2Cert"
$nodeLoginName1 = "AGNode2_Login"
$nodeUserName1 = "AGNode2_User"
$node1IP = "10.0.0.5"

$nodeName2 = "AGNode3"
$certificateName2 = "AGNode3Cert"
$nodeLoginName2 = "AGNode3_Login"
$nodeUserName2 = "AGNode3_User"
$node2IP = "10.0.0.7"

$nodeName3 = "AGNode4"
$certificateName3 = "AGNode4Cert"
$nodeLoginName3 = "AGNode4_Login"
$nodeUserName3 = "AGNode4_User"
$node3IP = "10.0.0.6"

$FolderName = "AGfolder"
$FolderPath = "C:\$FolderName"

#Enable AOAG from SQL Configuration manager
Enable-SqlAlwaysOn -Path "SQLSERVER:\Sql\$ServerName\DEFAULT" -force

Copy-Item "\\$node1IP\$FolderName\$certificateName1.crt" -Destination "$FolderPath\"

Copy-Item "\\$node2IP\$FolderName\$certificateName2.crt" -Destination "$FolderPath\"

Copy-Item "\\$node3IP\$FolderName\$certificateName3.crt" -Destination "$FolderPath\"

#Create logins and give permission on certificates to use that certificates to login

$createLogin1 = @"
USE master;   
CREATE LOGIN $nodeLoginName1 WITH PASSWORD = 'PassWord123!';   
GO   
--create a user from the login 
CREATE USER $nodeUserName1 FOR LOGIN $nodeLoginName1;   
GO   
--create a certificate that the login uses for authentication 
CREATE CERTIFICATE $certificateName1   
   AUTHORIZATION $nodeUserName1   
   FROM FILE = 'C:\$FolderName\$certificateName1.crt'   
GO  
--grant connect for login 
GRANT CONNECT ON ENDPOINT::hadr_endpoint TO [$nodeLoginName1];   
GO 
"@

# Execute the SQL commands
sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createLogin1

$createLogin2 = @"
USE master;   
CREATE LOGIN $nodeLoginName2 WITH PASSWORD = 'PassWord123!';   
GO   
--create a user from the login 
CREATE USER $nodeUserName2 FOR LOGIN $nodeLoginName2;   
GO   
--create a certificate that the login uses for authentication 
CREATE CERTIFICATE $certificateName2
   AUTHORIZATION $nodeUserName2   
   FROM FILE = 'C:\$FolderName\$certificateName2.crt'   
GO  
--grant connect for login 
GRANT CONNECT ON ENDPOINT::hadr_endpoint TO [$nodeLoginName2];   
GO 
"@

# Execute the SQL commands
sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createLogin2


$createLogin3 = @"
USE master;   
CREATE LOGIN $nodeLoginName3 WITH PASSWORD = 'PassWord123!';   
GO   
--create a user from the login 
CREATE USER $nodeUserName3 FOR LOGIN $nodeLoginName3;   
GO   
--create a certificate that the login uses for authentication 
CREATE CERTIFICATE $certificateName3
   AUTHORIZATION $nodeUserName3
   FROM FILE = 'C:\$FolderName\$certificateName3.crt'   
GO  
--grant connect for login 
GRANT CONNECT ON ENDPOINT::hadr_endpoint TO [$nodeLoginName3];   
GO 
"@

# Execute the SQL commands
sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createLogin3

