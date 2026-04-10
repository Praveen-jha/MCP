# #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_run_command
resource "azurerm_virtual_machine_run_command" "sql-vm-ha-primary-server-powershell-2" {
  name               = "sql-vm-ha-primary-server-powershell-2"
  location           = data.azurerm_resource_group.this.location
  virtual_machine_id = azurerm_windows_virtual_machine.this["instance-0"].id

  source {
    script = <<-POWERSHELL
      #Define all the required variables
      $availabilityGroupName = "${var.availability_group_name}"
      $listenerName = "${var.listener_name}"
      $listenerIP = "${var.listener_ip}"
      $listenerIPName = "listener-IP"
      $clusterIP = "${var.cluster_ip}"

      $SqlAdminUser = "sqladmin"
      $SqlPrimaryServerAdminPassword = "password@123"
      $SqlSecondaryServer1AdminPassword = "password@123"
      $SqlSecondaryServer2AdminPassword = "password@123"
      $SqlSecondaryServer3AdminPassword = "password@123"

      $primaryServerName = "${var.name[0]}"
      $secondaryServer1Name = "${var.name[1]}"
      $secondaryServer2Name = "${var.name[2]}"
      $secondaryServer3Name = "${var.name[3]}"

      # Create Availability Group
      $createAvailabilityGroup = @"
      CREATE AVAILABILITY GROUP [$availabilityGroupName]
      WITH (AUTOMATED_BACKUP_PREFERENCE = SECONDARY,
      DB_FAILOVER = OFF,
      DTC_SUPPORT = NONE,
      REQUIRED_SYNCHRONIZED_SECONDARIES_TO_COMMIT = 0)
      FOR DATABASE [db]
      REPLICA ON N'$primaryServerName' WITH (ENDPOINT_URL = N'TCP://$primaryServerName.products.cdk.com:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
        N'$secondaryServer1Name' WITH (ENDPOINT_URL = N'TCP://$secondaryServer1Name.products.cdk.com:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
        N'$secondaryServer2Name' WITH (ENDPOINT_URL = N'TCP://$secondaryServer2Name.products.cdk.com:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
        N'$secondaryServer3Name' WITH (ENDPOINT_URL = N'TCP://$secondaryServer3Name.products.cdk.com:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));

      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlPrimaryServerAdminPassword -S $primaryServerName -Q $createAvailabilityGroup

      $joinAvailabilityGroupinSecondaryServer1 = @"
      ALTER AVAILABILITY GROUP [$availabilityGroupName] JOIN;
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName] GRANT CREATE ANY DATABASE;
      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlSecondaryServer1AdminPassword -S $secondaryServer1Name -Q $joinAvailabilityGroupinSecondaryServer1

      $joinAvailabilityGroupinSecondaryServer2 = @"
      ALTER AVAILABILITY GROUP [$availabilityGroupName] JOIN;
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName] GRANT CREATE ANY DATABASE;
      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlSecondaryServer2AdminPassword -S $secondaryServer2Name -Q $joinAvailabilityGroupinSecondaryServer2


      $joinAvailabilityGroupinSecondaryServer3 = @"
      ALTER AVAILABILITY GROUP [$availabilityGroupName] JOIN;
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName] GRANT CREATE ANY DATABASE;
      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlSecondaryServer3AdminPassword -S $secondaryServer3Name -Q $joinAvailabilityGroupinSecondaryServer3


      # Add IP Address resource for listener
      Add-ClusterResource -Name $listenerIPName -ResourceType "IP Address" -Group $availabilityGroupName

      # Set the IP resource parameters (static, no DHCP)
      Get-ClusterResource -Name $listenerIPName | Set-ClusterParameter -Multiple @{

          "Network" = "Cluster Network 1";

          "Address" = $listenerIP;

          "SubnetMask" = "255.255.255.0";

          "EnableDHCP" = 0

      }

      # Add the Network Name resource for the listener

      Add-ClusterResource -Name $listenerName -Group $availabilityGroupName -ResourceType "Network Name"

      # Set parameters on the Network Name resource (listener FQDN and RegisterAllProvidersIP)

      Get-ClusterResource -Name $listenerName | Set-ClusterParameter -Multiple @{

          "DnsName" = $listenerName;

          "RegisterAllProvidersIP" = 1

      }

      #Stop Cluster Resource  
      Stop-ClusterResource -Name $availabilityGroupName -Verbose

      # Set the Network Name resource to be dependent on the IP Address resource

      Set-ClusterResourceDependency -Resource $listenerName -Dependency "[$listenerIPName]"
      Set-ClusterResourceDependency -Resource $availabilityGroupName -Dependency "[$listenerName]"

      #Start Cluster Resource
      Start-ClusterResource -Name $availabilityGroupName -Verbose

      # Bring the listener network name resource online

      Start-ClusterResource -Name $listenerName -Verbose

      $ClusterNetworkName = "Cluster Network 1" # The cluster network name. Use Get-ClusterNetwork on Windows Server 2012 or later to find the name.

      $IPResourceName = $listenerIPName # The IP address resource name.

      $ListenerILBIP = $listenerIP # The IP address of the internal load balancer. This is the static IP address for the load balancer that you configured in the Azure portal.

      [int]$ListenerProbePort = 59999

      Import-Module FailoverClusters

      Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ListenerILBIP";"ProbePort"=$ListenerProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"EnableDhcp"=0}

      #Take listener-IP is offline and then online again.

      Stop-ClusterResource -Name $listenerIPName -Verbose
      Start-ClusterResource -Name $listenerIPName -Verbose
      Start-ClusterResource -Name $listenerName -Verbose 


      $ClusterNetworkName = "Cluster Network 1" # The cluster network name. Use Get-ClusterNetwork on Windows Server 2012 or later to find the name.

      $IPResourceName = "Cluster IP Address" # The IP address resource name.

      $ClusterCoreIP = $clusterIP # The IP address of the cluster IP resource. This is the static IP address for the load balancer that you configured in the Azure portal.

      [int]$ClusterProbePort = 58888 # The probe port from WSFCEndPointprobe in the Azure portal. This port must be different from the probe port for the availability group listener.

      Import-Module FailoverClusters

      Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ClusterCoreIP";"ProbePort"=$ClusterProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"EnableDhcp"=0}

      #Take Cluster IP Address is offline and then online again
      Stop-ClusterResource -Name $IPResourceName -Verbose
      Start-ClusterResource -Name $IPResourceName -Verbose
      Start-ClusterResource -Name "Cluster Name" -Verbose 

      Start-ClusterResource -Name $availabilityGroupName -Verbose

      #Add Listener Port
      $listenerPort = @"
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY LISTENER N'$listenerName' (PORT=1433);
      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlPrimaryServerAdminPassword -S $primaryServerName -Q $listenerPort

      #Enable Read Only Routing
      $readOnlyRouting = @"
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer2Name' WITH (SECONDARY_ROLE(READ_ONLY_ROUTING_URL = N'TCP://$secondaryServer2Name.products.cdk.com:1433'))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer3Name' WITH (SECONDARY_ROLE(READ_ONLY_ROUTING_URL = N'TCP://$secondaryServer3Name.products.cdk.com:1433'))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$primaryServerName' WITH (SECONDARY_ROLE(READ_ONLY_ROUTING_URL = N'TCP://$primaryServerName.products.cdk.com:1433'))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer1Name' WITH (SECONDARY_ROLE(READ_ONLY_ROUTING_URL = N'TCP://$secondaryServer1Name.products.cdk.com:1433'))
      GO

      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer2Name' WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST = (N'$primaryServerName',N'$secondaryServer1Name',N'$secondaryServer3Name')))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer3Name' WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST = (N'$primaryServerName',N'$secondaryServer1Name',N'$secondaryServer2Name')))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$primaryServerName' WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST = (N'$secondaryServer1Name',N'$secondaryServer2Name',N'$secondaryServer3Name')))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer1Name' WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST = (N'$primaryServerName',N'$secondaryServer2Name',N'$secondaryServer3Name')))
      GO

      "@
      sqlcmd -U $SqlAdminUser -P $SqlPrimaryServerAdminPassword -S $primaryServerName -Q $readOnlyRouting
    POWERSHELL
  }
  depends_on = [
    azurerm_virtual_machine_run_command.sql-vm-ha-common-powershell-2
  ]

  tags = merge(var.vm_tags, var.tags)
}
