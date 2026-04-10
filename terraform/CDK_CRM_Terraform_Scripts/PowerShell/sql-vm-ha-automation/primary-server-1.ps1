#Define all the required variables
$SqlAdminUser = "sqladmin"
$SqlServerAdminPassword = "password@123"
$ServerName = "sqlvmtestf1"
$FolderName = "AGfolder"

$ClusterName = "agwgag"
$Nodes =  @("10.0.0.4", "10.0.0.5")
$ClusterStaticAddress = "10.0.0.6"
$StorageAccountName = ""
$StorageAccountAccessKey = ""

#Create Failover Cluster
New-Cluster -Name $ClusterName -Node $Nodes -StaticAddress $ClusterStaticAddress -NoStorage -AdministrativeAccessPoint DNS -ManagementPointNetworkType Singleton

#Set Cluster Quorum
Set-ClusterQuorum -CloudWitness -Cluster $ClusterName -AccountName $StorageAccountName -AccessKey $StorageAccountAccessKey

#Create a Database
$createDatabase = @"
CREATE DATABASE db;
GO
USE db;
GO
CREATE TABLE dbo.emp 
( 
    ID int IDENTITY(1,1) NOT NULL, 
    FirstName varchar(50), 
    LastName varchar(50) 
);
GO
INSERT INTO emp (FirstName, LastName) VALUES ('John', 'Doe');
INSERT INTO emp (FirstName, LastName) VALUES ('Jane', 'Doe');
GO
"@

# Execute the SQL commands
sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createDatabase

# Create backup of the Database
sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q "BACKUP DATABASE [db] TO DISK='C:\$FolderName\db.bak' WITH FORMAT"

