variable "aks_name" {
  description = "Name of the Managed Kubernetes Cluster"
  type        = string
}

variable "location" {
  description = "Location of the Managed Kubernetes Cluster"
  type        = string
}

variable "rg_name" {
  description = "Specifies the Resource Group where the Managed Kubernetes Cluster should exist"
  type        = string
}

variable "node_pool_name" {
  description = "Name which should be used for the default Kubernetes Node Pool"
  type        = string
}

variable "vm_size" {
  description = "The size of the Virtual Machine inside the Default Pool"
  type        = string
  default     = "Standard_B2ms"
}

variable "sku_tier" {
  description = "SKU Tier that should be used for this Kubernetes Cluster"
  type        = string
}

variable "private_cluster_enabled" {
  description = "This provides Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located"
  type        = bool
  default     = true
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster"
  type        = string
}

variable "network_plugin" {
  description = "Network plugin to use for networking"
  type        = string
}

variable "network_policy" {
  description = "Network Policy to use for networking"
  type        = string
}

variable "vnet_subnet_id" {
  description = "ID of a Subnet where the Kubernetes Node Pool should exist"
  type        = string
}

variable "os_sku" {
  description = "Specifies the OS SKU used by the agent pool"
  type        = string
  default     = "Linux"
}

variable "os_disk_type" {
  description = "The type of disk which should be used for the Operating System"
  type        = string
  default     = "Managed"
}

variable "os_disk_size_gb" {
  description = "The size of the OS Disk which should be used for each agent in the Node Pool"
  type        = string
  default     = "32"
}

variable "node_pool_zones" {
  description = "Specifies a list of Availability Zones in which this Kubernetes Cluster should be located"
  type        = set(string)
  default     = ["1"]
}

variable "node_count" {
  description = "The initial number of nodes which should exist in this Node Pool"
  type        = number
  default     = 1
}

variable "enable_auto_scaling" {
  description = "Parameter that defines whether autoscaling has been enabled or not"
  type        = bool
  default     = false
}

variable "system_max_count" {
  description = "Defines Maximum number of Nodes that should exist in this Node Pool"
  type        = number
  default     = 3
}

variable "system_min_count" {
  description = "Defines Minimum number of Nodes that should exist in this Node Pool"
  type        = number
  default     = 1
}

variable "system_max_pods" {
  description = "Defines Maximum number of Pods that run on each Agent"
  type        = number
  default     = 10
}

variable "identity_type" {
  description = "Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster"
  type        = string
}

variable "aks_tags" {
  description = "A mapping of tags to assign to AKS"
  type        = map(string)
}

variable "node_resource_group" {
  description = "The auto-generated Resource Group which contains the resources for this Kubernetes Cluster"
  type        = string
}

variable "private_cluster_public_fqdn_enabled" {
  description = "Specifies whether a Public FQDN for this Private Cluster should be added"
  type        = bool
}

variable "node_pool" {
  description = "Defines the Node Pool Configuration which is present inside Kubernetes Cluster"
  type = map(object({
    name                            = string
    mode                            = string
    vm_size                         = string
    os_type                         = string
    os_sku                          = string
    os_disk_type                    = string
    os_disk_size_gb                 = string
    enable_auto_scaling             = bool
    node_count                      = number
    max_count                       = number
    min_count                       = number
    zones                           = list(string)
    usr_temporary_name_for_rotation = string
    max_pods                        = number
    node_labels                     = map(string)
    host_encryption_enabled         = bool
  }))
}

variable "azure_rbac_enabled" {
  description = "Specifies whether Azure Role-Based Access Control (RBAC) is enabled for AKS."
  type        = bool
}

variable "tenant_id" {
  description = "The Azure Active Directory (AAD) tenant ID associated with the AKS cluster."
  type        = string
}

variable "local_account_disabled" {
  description = "Specifies whether the local Kubernetes admin account is disabled."
  type        = string
}

variable "automatic_upgrade_channel" {
  description = "The automatic upgrade channel for the AKS cluster"
  type        = string
}

variable "disk_encryption_set_id" {
  description = "The ID of the disk encryption set used to encrypt the OS and data disks of the AKS nodes."
  type        = string
}

variable "host_encryption_enabled" {
  description = "Specifies whether host encryption is enabled for the AKS nodes."
  type        = bool
}

variable "azure_policy_enabled" {
  description = "Specifies whether Azure Policy is enabled for the AKS cluster."
  type        = bool
}

variable "secret_rotation_enabled" {
  description = "Specifies whether automatic secret rotation is enabled for AKS-managed secrets."
  type        = bool
}

variable "only_critical_addons_enabled" {
  description = "Specifies whether only critical add-ons are enabled in the AKS cluster."
  type        = bool
}

variable "authorized_ip_ranges" {
  description = "Specifies the range of Ip's that should access the Cluster"
  type        = list(string)
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace Id for the OMS Agent"
  type        = string
}

variable "osm_agent_enabled" {
  description = "Is the OMS Agent enabled"
  type        = bool
  default     = true
}

variable "sys_temporary_name_for_rotation" {
  description = "Temporary name for the system node pool"
  type        = string
}

variable "outbound_type" {
  description = "Outbound type of AKS"
  type        = string
}

variable "kubernetes_version" {
  description = "kubernetes version that will be used to create the cluster"
  type        = string
  default     = "1.32"
}
