// variables.tf
// This file defines the input variables for the azurerm_subnet module.

variable "subnet_name" {
  description = "(Required) The name of the Subnet."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Subnet will be created."
  type        = string
}

variable "subnet_address_prefixes" {
  description = "(Required) A list of address prefixes to use for the Subnet (e.g., [\"10.0.1.0/24\"])."
  type        = list(string)
}

variable "virtual_network_name" {
  description = "(Required) The name of the Virtual Network where the Subnet will be created."
  type        = string
}

variable "private_endpoint_network_policies" {
  description = "(Optional) Enable or Disable network policies for the private endpoint on the subnet. Possible values are Disabled, Enabled, NetworkSecurityGroupEnabled and RouteTableEnabled. Defaults to Disabled."
  type        = string
  default     = "Disabled"

  validation {
    condition = contains([
      "Disabled",
      "Enabled",
      "NetworkSecurityGroupEnabled",
      "RouteTableEnabled"
    ], var.private_endpoint_network_policies)
    error_message = "The private_endpoint_network_policies must be one of 'Disabled', 'Enabled', 'NetworkSecurityGroupEnabled', or 'RouteTableEnabled'."
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "(Optional) Enable or Disable network policies for the private link service on the Subnet. Set to null if not required."
  type        = bool
  default     = null
}

variable "service_endpoints" {
  description = "(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web. Set to null or an empty list if not required."
  type        = list(string)
  default     = []

  validation {
    condition = var.service_endpoints == null || (
      alltrue([
        for endpoint in var.service_endpoints : contains([
          "Microsoft.AzureActiveDirectory",
          "Microsoft.AzureCosmosDB",
          "Microsoft.ContainerRegistry",
          "Microsoft.EventHub",
          "Microsoft.KeyVault",
          "Microsoft.ServiceBus",
          "Microsoft.Sql",
          "Microsoft.Storage",
          "Microsoft.Storage.Global",
          "Microsoft.Web"
        ], endpoint)
      ])
    )
    error_message = "Each service_endpoint in the list must be one of the supported values: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global, or Microsoft.Web."
  }
}

variable "default_outbound_access_enabled" {
  description = "(Optional) Should the default outbound access be enabled for the Subnet? Set to null if not required."
  type        = bool
  default     = null
}

variable "service_endpoint_policy_ids" {
  description = "(Optional) A list of Service Endpoint Policy IDs to associate with the Subnet. Set to null or an empty list if not required."
  type        = list(string)
  default     = null
}

variable "subnet_delegations" {
  description = "(Optional) Configuration for subnet delegation. Provide as a map with 'name' (string, for the delegation block), 'service_delegation_name' (string), and 'actions' (list(string)). Set to {} (an empty map) if no delegation is required."
  type        = any
  nullable    = true
  default     = {}

  validation {
    condition = var.subnet_delegations == {} || (
      can(var.subnet_delegations.service_delegation_name) ? (
        contains([
          "GitHub.Network/networkSettings",
          "Informatica.DataManagement/organizations",
          "Microsoft.ApiManagement/service",
          "Microsoft.Apollo/npu",
          "Microsoft.App/environments",
          "Microsoft.App/testClients",
          "Microsoft.AVS/PrivateClouds",
          "Microsoft.AzureCosmosDB/clusters",
          "Microsoft.BareMetal/AzureHostedService",
          "Microsoft.BareMetal/AzureHPC",
          "Microsoft.BareMetal/AzurePaymentHSM",
          "Microsoft.BareMetal/AzureVMware",
          "Microsoft.BareMetal/CrayServers",
          "Microsoft.BareMetal/MonitoringServers",
          "Microsoft.Batch/batchAccounts",
          "Microsoft.CloudTest/hostedpools",
          "Microsoft.CloudTest/images",
          "Microsoft.CloudTest/pools",
          "Microsoft.Codespaces/plans",
          "Microsoft.ContainerInstance/containerGroups",
          "Microsoft.ContainerService/managedClusters",
          "Microsoft.ContainerService/TestClients",
          "Microsoft.Databricks/workspaces",
          "Microsoft.DBforMySQL/flexibleServers",
          "Microsoft.DBforMySQL/servers",
          "Microsoft.DBforMySQL/serversv2",
          "Microsoft.DBforPostgreSQL/flexibleServers",
          "Microsoft.DBforPostgreSQL/serversv2",
          "Microsoft.DBforPostgreSQL/singleServers",
          "Microsoft.DelegatedNetwork/controller",
          "Microsoft.DevCenter/networkConnection",
          "Microsoft.DevOpsInfrastructure/pools",
          "Microsoft.DevOpsInfrastructure/pools",
          "Microsoft.DocumentDB/cassandraClusters",
          "Microsoft.Fidalgo/networkSettings",
          "Microsoft.HardwareSecurityModules/dedicatedHSMs",
          "Microsoft.Kusto/clusters",
          "Microsoft.LabServices/labplans",
          "Microsoft.Logic/integrationServiceEnvironments",
          "Microsoft.MachineLearningServices/workspaces",
          "Microsoft.Netapp/volumes",
          "Microsoft.Network/applicationGateways",
          "Microsoft.Network/dnsResolvers",
          "Microsoft.Network/managedResolvers",
          "Microsoft.Network/fpgaNetworkInterfaces",
          "Microsoft.Network/networkWatchers",
          "Microsoft.Network/virtualNetworkGateways",
          "Microsoft.Orbital/orbitalGateways",
          "Microsoft.PowerAutomate/hostedRpa",
          "Microsoft.PowerPlatform/enterprisePolicies",
          "Microsoft.PowerPlatform/vnetaccesslinks",
          "Microsoft.ServiceFabricMesh/networks",
          "Microsoft.ServiceNetworking/trafficControllers",
          "Microsoft.Singularity/accounts/networks",
          "Microsoft.Singularity/accounts/npu",
          "Microsoft.Sql/managedInstances",
          "Microsoft.Sql/managedInstancesOnebox",
          "Microsoft.Sql/managedInstancesStage",
          "Microsoft.Sql/managedInstancesTest",
          "Microsoft.Sql/servers",
          "Microsoft.StoragePool/diskPools",
          "Microsoft.StreamAnalytics/streamingJobs",
          "Microsoft.Synapse/workspaces",
          "Microsoft.Web/hostingEnvironments",
          "Microsoft.Web/serverFarms",
          "NGINX.NGINXPLUS/nginxDeployments",
          "PaloAltoNetworks.Cloudngfw/firewalls",
          "Qumulo.Storage/fileSystems",
          "Oracle.Database/networkAttachments"
        ], var.subnet_delegations.service_delegation_name)
      ) : true
    )
    error_message = "The 'service_delegation_name' must be one of the supported Azure service names for delegation and must be a string."
  }

  validation {
    condition = var.subnet_delegations == {} || (
      can(var.subnet_delegations.actions) ? (
        length(var.subnet_delegations.actions) == 0 ||
        alltrue([
          for action in var.subnet_delegations.actions : contains([
            "Microsoft.Network/networkinterfaces/*",
            "Microsoft.Network/publicIPAddresses/join/action",
            "Microsoft.Network/publicIPAddresses/read",
            "Microsoft.Network/virtualNetworks/read",
            "Microsoft.Network/virtualNetworks/subnets/action",
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
          ], action)
        ])
      ) : true
    )
    error_message = "Each 'action' in the delegation must be one of the supported delegation actions."
  }
}

variable "network_security_group_id" {
  description = "(Required) Network Security Group id to associate subnet with."
  type        = string
}

variable "subnet_nsg_association" {
  type        = bool
  default     = false
  description = "subnet nsg assocation bool: defaults to true"
}