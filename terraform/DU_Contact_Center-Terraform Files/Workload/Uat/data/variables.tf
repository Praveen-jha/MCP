# The geographical location where the resources will be deployed.
variable "location" {
  type        = string
  description = "Location of the resources."
}

# Variable for the Tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the Tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID of UAT."
}

variable "rg_creation" {
  description = "Resource Creation"
  type        = string
}

variable "location_shortname" {
  description = "Location shortname"
  type        = string
}

variable "workload_type" {
  description = "workload type of the resource"
  type        = string
}

variable "resource_group_tags" {
  description = "resource group tags"
  type        = map(string)
}

variable "tags" {
  type        = map(string)
  description = "Tags associated with the reousrces."
}

variable "apim_config" {
  type = object({
    subnet_name                   = string
    virtual_network_name          = string
    resource_group_name           = string
    publisher_name                = string
    publisher_email               = string
    sku_name                      = string
    public_network_access_enabled = bool
    public_ip_name                = string
    virtual_network_type          = string
    tags                          = map(string)
    identity = object({
      type = string
    })
  })
}

variable "container_registry" {
  type = object({
    sku                           = string
    public_network_access_enabled = bool
    identity = object({
      type = string
    })
    tags = map(string)
  })
}