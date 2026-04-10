// variables.tf
// This file defines the input variables for the azurerm_api_management module.
variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID for the primary deployment."
}

variable "hub_subscription_id" {
  type = string
  description = "The Azure subscription ID for the primary deployment."
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "cdk-mr-dev" 
}

variable "name" {
  description = "Suffix for resource names"
  type        = string
  default     = "my-apim"
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the API Management Service should exist."
  type        = string
}

variable "network_resource_group" {
  description = "The name of the Resource Group where the Virtual Network and Subnet exist."
  type        = string
}

variable "subnet_name" {
  description = "The name of the Subnet. Used when virtual_network_type is not 'None'."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the Virtual Network. Used when virtual_network_type is not 'None'."
  type        = string
}

variable "public_ip_name" {
  description = "The name of the Public IP to create for the APIM service when virtual_network_type is 'External'."
  type        = string
  default     = null
}


variable "location" {
  description = "The Azure Region where the API Management Service should exist."
  type        = string
}

variable "publisher_name" {
  type        = string
  description = "(Required) The name of publisher/company."
}

variable "publisher_email" {
  type        = string
  description = "(Required) The email of publisher/company."
}

variable "sku_name" {
  type        = string
  description = "(Required) sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, BasicV2, Standard, StandardV2, Premium and PremiumV2. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1)."
  default     = "Developer_1"
}

variable "identity_type" {
  description = "(Required) Specifies the type of Managed Service Identity that should be configured on this APIM. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this APIM."
  type        = list(string)
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags for the SQL Managed Instance"

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

variable "availability_zone" {
  description = "Set to true to deploy across availability zones."
  type        = bool
  default     = false
}

variable "zones" {
  description = "A list of availability zones to use (e.g., ['1', '2', '3'])."
  type        = list(string)
  default     = null
}

variable "public_network_access_enabled" {
  description = "Is Public Network Access enabled for the APIM."
  type        = bool
  default     = true # Defaulting to true is safer than null
}

variable "virtual_network_type" {
  type        = string
  description = "The type of virtual network. Valid values: 'None', 'External', 'Internal'. 'External' requires a Public IP. 'Internal' is private."
  default     = "Internal"
}

variable "enable_private_endpoint" {
  description = "Whether to enable private endpoint for the web app"
  type        = bool
  default     = false
}

variable "create_private_dns_record" {
  type        = bool
  description = "Set to true to create a CNAME record in a central private DNS zone."
  default     = false
}

variable "private_dns_zone_rg_name" {
  type        = string
  description = "The name of the resource group containing the 'privatelink.database.windows.net' DNS zone."
  default     = ""
}

variable "private_zone_domain" {
  type        = string
  description = "The name of the Privatezone 'privatelink.database.windows.net' DNS zone."
  default     = ""
}


variable "public_ip_required" {
  type        = bool
  description = "Set to true to create a Public IP for the APIM service when virtual_network_type is 'External'."
  default     = false
}


variable "private_endpoint_subnet_name" {
  description = "The name of the subnet for the private endpoint. Used when enable_private_endpoint is true."
  type        = string
  default     = null
}

variable "log_analytics_workspace_name" {
  description = "The name of an existing Log Analytics Workspace. If left empty, a new one will be created."
  type        = string
  default     = ""
}

variable "sku_name_log_analytics" {
  description = "The SKU of the Log Analytics Workspace."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The retention period for the Log Analytics Workspace in days."
  type        = number
  default     = 30
}

variable "application_insights_name" {
  description = "The name of an existing Application Insights instance. If left empty, a new one will be created."
  type        = string
  default     = ""
}
variable "application_type" {
  description = "The type of the application in application insight."
  type        = string
  default     = "web"
}

variable "enable_defender_for_apis" {
  description = "Set to true to enable Microsoft Defender for APIs on the subscription."
  type        = bool
}

variable "app_insight_enabled" {
  description = "Set to true to create Application Insight"
  type        = bool
}

variable "log_analytics_workspace_enabled" {
  description = "Set to true to create Log Analytics Workspace"
  type        = bool
}

variable "enable_diagnostic" {
  description = "Set to true to enable APIM diagnostic logging"
  type        = bool
  default     = true 
}

# }
#varibales for API Management Diagnostic Resource
# Required variables
variable "identifier" {
  description = "The diagnostic identifier for the API Management diagnostic"
  type        = string 
  default = "applicationinsights"
}

# Optional variables with default values
variable "always_log_errors" {
  description = "Always log errors. Send telemetry if there is an erroneous condition, regardless of sampling settings"
  type        = bool
  default     = null
}

variable "log_client_ip" {
  description = "Log client IP address"
  type        = bool
  default     = null
}

variable "verbosity" {
  description = "Logging verbosity. Possible values are verbose, information or error"
  type        = string
  default     = null
  validation {
    condition     = var.verbosity == null || contains(["verbose", "information", "error"], var.verbosity)
    error_message = "The verbosity must be one of: verbose, information, or error."
  }
}

variable "sampling_percentage" {
  description = "Sampling percentage for the diagnostic. For high traffic APIs, please read this documentation to understand performance implications"
  type        = number
  default     = null
  validation {
    condition     = var.sampling_percentage == null || (var.sampling_percentage >= 0 && var.sampling_percentage <= 100)
    error_message = "The sampling_percentage must be between 0 and 100."
  }
}

variable "operation_name_format" {
  description = "The format of the Operation Name for Application Insights telemetries. Possible values are Name, and Url"
  type        = string
  default     = null
  validation {
    condition     = var.operation_name_format == null || contains(["Name", "Url"], var.operation_name_format)
    error_message = "The operation_name_format must be either 'Name' or 'Url'."
  }
}

# Complex object variables for dynamic blocks
variable "frontend_request" {
  description = "A frontend_request block for API Management diagnostic"
  type = object({
    body_bytes     = optional(number)
    headers_to_log = optional(set(string))
    data_masking = optional(object({
      query_params = optional(list(object({
        mode  = string
        value = string
      })))
      headers = optional(list(object({
        mode  = string
        value = string
      })))
    }))
  })
  default = null
}

variable "frontend_response" {
  description = "A frontend_response block for API Management diagnostic"
  type = object({
    body_bytes     = optional(number)
    headers_to_log = optional(set(string))
    data_masking = optional(object({
      query_params = optional(list(object({
        mode  = string
        value = string
      })))
      headers = optional(list(object({
        mode  = string
        value = string
      })))
    }))
  })
  default = null
}

variable "backend_request" {
  description = "A backend_request block for API Management diagnostic"
  type = object({
    body_bytes     = optional(number)
    headers_to_log = optional(set(string))
    data_masking = optional(object({
      query_params = optional(list(object({
        mode  = string
        value = string
      })))
      headers = optional(list(object({
        mode  = string
        value = string
      })))
    }))
  })
  default = null
}

variable "backend_response" {
  description = "A backend_response block for API Management diagnostic"
  type = object({
    body_bytes     = optional(number)
    headers_to_log = optional(set(string))
    data_masking = optional(object({
      query_params = optional(list(object({
        mode  = string
        value = string
      })))
      headers = optional(list(object({
        mode  = string
        value = string
      })))
    }))
  })
  default = null
}

#variables for API Management API Resource
# Required variables
variable "apis" {
  description = "Map of APIs to create"
  type = map(object({
    display_name = string
    path         = string
    service_url  = string
    revision     = string
    protocols   = optional(list(string))
    create_policy = bool
  }))
  default = {
   
  }
  
  }

# Complex object variables for dynamic blocks
variable "import_config" {
  description = "An import block for API Management API"
  type = object({
    content_format = string
    content_value  = string
    wsdl_selector = optional(object({
      service_name  = string
      endpoint_name = string
    }))
  })
  default = null

  validation {
    condition = var.import_config == null || contains([
      "openapi", "openapi+json", "openapi+json-link", "openapi-link",
      "swagger-json", "swagger-link-json", "wadl-link-json", "wadl-xml",
      "wsdl", "wsdl-link"
    ], var.import_config.content_format)
    error_message = "The content_format must be one of: openapi, openapi+json, openapi+json-link, openapi-link, swagger-json, swagger-link-json, wadl-link-json, wadl-xml, wsdl, or wsdl-link."
  }
}

variable "subscription_key_parameter_names" {
  description = "A subscription_key_parameter_names block for API Management API"
  type = object({
    header = string
    query  = string
  })
  default = null
}

variable "license" {
  description = "A license block for API Management API"
  type = object({
    name = optional(string)
    url  = optional(string)
  })
  default = null
}

variable "contact" {
  description = "A contact block for API Management API"
  type = object({
    name  = optional(string)
    url   = optional(string)
    email = optional(string)
  })
  default = null
}

variable "oauth2_authorization" {
  description = "An oauth2_authorization block for API Management API"
  type = object({
    authorization_server_name = string
    scope                     = optional(string)
  })
  default = null
}

variable "openid_authentication" {
  description = "An openid_authentication block for API Management API"
  type = object({
    openid_provider_name         = string
    bearer_token_sending_methods = optional(set(string))
  })
  default = null

  validation {
    condition = var.openid_authentication == null || (
      var.openid_authentication.bearer_token_sending_methods == null ||
      alltrue([
        for method in var.openid_authentication.bearer_token_sending_methods :
        contains(["authorizationHeader", "query"], method)
      ])
    )
    error_message = "The bearer_token_sending_methods must contain only 'authorizationHeader' or 'query'."
  }
}
# Header policy inputs
variable "inbound_header_name" {
  type    = string
  default = "X-Contoso-Env"
}

variable "inbound_header_value" {
  type    = string
  default = "demo"
}

variable "inbound_header_exists_action" {
  type    = string
  default = "override" # allowed: append | overwrite/override | skip
}

# Products and which APIs each includes
variable "products" {
  description = "Map of products and the APIs they expose"
  type = map(object({
    display_name        = string
    description         = optional(string)
    approval_required   = optional(bool)
    subscriptions_limit = optional(number)
    published           = optional(bool)
    terms               = optional(string)
    apis                = list(string) # keys of var.apis
  }))
  default = {
 
  }
}

# Custom Groups
variable "groups" {
  description = "Custom APIM groups"
  type = map(object({
    display_name = string
    description  = optional(string)
  }))
  default = {
  
  }
}

# Which groups attach to which products
variable "product_groups" {
  description = "Map of product_key => [group_keys]"
  type        = map(list(string))
  default = {
 
  }
}

# Users and which groups they join
variable "users" {
  description = "Users to create inside APIM"
  type = map(object({
    first_name = string
    last_name  = string
    email      = string
    password   = string
    note       = optional(string)
    state      = optional(string)
    groups     = list(string) # keys of var.groups
  }))
  default = {
  
  }
}

# Subscriptions: user + product
variable "subscriptions" {
  description = "Subscriptions to create per user/product"
  type = map(object({
    display_name = string
    product_key  = string # key in var.products
    user_key     = string # key in var.users
  }))
  default = {
  
  }
}


# Subscription pricing for Defender for APIs
variable "subscription_pricing" {
  description = "The ID of the Security Center Subscription Pricing to enable Defender for APIs."
  type = object({
    tier          = string
    subplan       = string
    resource_type = string
  })
  default = ({

  })

}




# Scenario 1: Standard APIM (No VNet)
# Azure manages the public endpoint automatically.
# # terraform.tfvars
# virtual_network_type = "None"

# Scenario 2: External APIM (In VNet, Publicly Accessible)
# This configuration will now correctly create a Public IP and associate it with the VNet-integrated APIM, resolving your error.

# # terraform.tfvars
# virtual_network_type = "External"
# subnet_id            = ""

# Scenario 3: Internal APIM (In VNet, Private)
# This configuration will not create a Public IP and will make the APIM private to the VNet.
# # terraform.tfvars
# public_network_access_enabled = false
# virtual_network_type = "Internal"
# subnet_id            = ""
# # ... other variables
