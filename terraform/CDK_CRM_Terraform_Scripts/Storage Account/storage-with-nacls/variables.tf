variable "subscription_id" {
  type        = string
  description = "Azure subscription ID."
}

variable "prefix" {
  type        = string
  description = "Prefix of the resource name"
}

variable "location" {
  type        = string
  default     = "centralus"
  description = "Location of the resource group."
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "Tags for resource"

  validation {
    condition = alltrue([
      contains(keys(var.tags), "cdk_asset_id"),
      contains(keys(var.tags), "cdk_asset_name"),
      contains(keys(var.tags), "cdk_portfolio"),
      contains(keys(var.tags), "cdk_sub_portfolio"),
      contains(keys(var.tags), "cdk_provisioner"),
      contains(keys(var.tags), "cdk_environment"),
      contains(keys(var.tags), "cdk_app_criticality"),
      contains(keys(var.tags), "cdk_account_type"),
      contains(keys(var.tags), "cdk_cluster_type")
    ])
    error_message = "The variable \"tags\" must contain *all* of the following: \"cdk_asset_id\", \"cdk_asset_name\", \"cdk_portfolio\", \"cdk_sub_portfolio\", \"cdk_provisioner\", \"cdk_environment\", \"cdk_app_criticality\", \"cdk_account_type\", \"cdk_cluster_type\""
  }
}
variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "The storage accoun tier."
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "The replication setting"
}

variable "storage_account_name" {
  type        = string
  description = "The storage account to use"
}

variable "storage_container_name" {
  type        = string
  description = "The storage container to use"
}

variable "network_rules" {
  description = "A network_rules block - Network access rules for the storage account."
  type = object({
    default_action             = string                 # Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow
    bypass                     = optional(set(string))  # Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None
    ip_rules                   = optional(list(string)) # List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. /31 CIDRs, /32 CIDRs, and Private IP address ranges are not allowed
    virtual_network_subnet_ids = optional(list(string)) # A list of resource ids for subnets
  })
  default = null
}
 