variable "location" {
  description = "The Azure region where the Azure Resources will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Azure Resources."
  type        = map(string)
  default     = {}
}

variable "name_config" {
  type = object({
    resource_group_creation  = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_creation = string //"Flag to indicate whether a new Virtual Network should be created or existing Virtual Network is used."
    subnet_creation          = string //"Flag to indicate whether a new Subnet should be created or existing Subnet is used."
    environment              = string //Deployment Environment (for example UAT or Prod).
    short_name               = string //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name             = string //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag              = string //Central US (cus), East US 2 (eus2)
    instance                 = string //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    application              = string //web, app, data, logs, mgmt, appvm, appserv, sqlvm, sqlmi
  })
}

variable "network" {
  type = object({
    address_space_vnet                     = list(string) //The address space for the virtual network.
    private_endpoint_subnet_address_prefix = list(string) //A list of address prefixes for the compute subnet.
    outbound_subnet_address_prefix         = list(string) //A list of address prefixes for the compute subnet.
    private_endpoint_subnet_application    = string       //pep,lb,appgw,web,data
    outbound_subnet_application            = string       //pep,lb,appgw,web,data
  })
}

variable "app_service_plan_sku_name" {
  type        = string
  description = "(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I1mv2, I2v2, I2mv2, I3v2, I3mv2, I4v2, I4mv2, I5v2, I5mv2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3, and Y1."
}

variable "app_service_plan_os_type" {
  type        = string
  description = "(Required) The O/S type for the App Services to be hosted in this plan. Possible values are Windows, Linux, and WindowsContainer."
}

variable "outbound_subnet_delegation" {
  type        = any
  nullable    = true
  description = "Configuration for subnet delegation. Provide as a map with 'name' (string, for the delegation block), 'service_delegation_name' (string), and 'actions' (list(string)). Set to {} (an empty map) if no delegation is required."
}

variable "public_network_access_enabled" {
  description = "Is Public Network Access enabled for the Windows Web App."
  type        = bool
}

variable "windows_web_app_site_config" {
  description = "A site_config block as defined below."
  type = list(object({
    always_on                                     = optional(bool)
    api_command_line                              = optional(string)
    api_definition_url                            = optional(string)
    api_management_api_id                         = optional(string) 
    app_command_line                              = optional(string)
    client_certificate_mode                       = optional(string)
    container_registry_use_managed_identity       = optional(bool)
    container_registry_managed_identity_client_id = optional(string)
    default_documents                             = optional(list(string))
    detailed_error_logging_enabled                = optional(bool)
    ftps_state                                    = optional(string)
    health_check_path                             = optional(string) 
    health_check_eviction_time_in_min             = optional(number)
    http2_enabled                                 = optional(bool)
    load_balancing_mode                           = optional(string)
    local_mysql_enabled                           = optional(bool)
    managed_pipeline_mode                         = optional(string)
    minimum_tls_version                           = optional(string) 
    remote_debugging_enabled                      = optional(bool)
    remote_debugging_version                      = optional(string)
    scm_minimum_tls_version                       = optional(string)
    scm_type                                      = optional(string)
    scm_use_main_ip_restriction                   = optional(bool)
    use_32_bit_worker                             = optional(bool)
    vnet_route_all_enabled                        = optional(bool)
    websockets_enabled                            = optional(bool)
    worker_count                                  = optional(number) 

    application_stack = optional(list(object({
      dotnet_version               = optional(string)
      current_stack                = optional(string)
      docker_registry_url          = optional(string)
      dotnet_core_version          = optional(string)
      java_embedded_server_enabled = optional(bool)
      tomcat_version               = optional(string)
      java_version                 = optional(string)
      node_version                 = optional(string)
      php_version                  = optional(string)
      python                       = optional(bool)
      docker_image_name            = optional(string)
      docker_registry_username     = optional(string)
      docker_registry_password     = optional(string)
    })))

    auto_heal_setting = optional(list(object({
      action = list(object({
        action_type = string
        custom_action = optional(list(object({
          executable = string
          parameters = optional(string)
        })))
      }))
      trigger = optional(list(object({
        private_memory_kb = optional(number)
        requests = optional(list(object({
          count    = number
          interval = string
        })))
        slow_request = optional(list(object({
          time_taken = string
          count      = number
          interval   = string
        })))
        status_code = optional(list(object({
          status_code_range = string
          count             = number
          interval          = string
        })))
      })))
    })))

    cors = optional(list(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool)
    })))

    ip_restriction = optional(list(object({
      action                    = optional(string)
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      headers = optional(list(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      })))
    })))

    scm_ip_restriction = optional(list(object({
      action                    = optional(string)
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      headers = optional(list(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      })))
    })))
  }))
  default = []
}

variable "existing_resource_group_name" {
  type        = string
  description = "Name of the Existing Resource Group"
}

variable "existing_virtual_network_name" {
  type        = string
  description = "Name of the Existing Virtual Network"
}

variable "existing_private_endpoint_subnet_name" {
  type        = string
  description = "Name of the Existing Inbound Subnet for App Service"
}

variable "existing_outbound_subnet_name" {
  type        = string
  description = "Name of the Existing Outbound Subnet for App Service"
}
