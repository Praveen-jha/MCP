variable "location" {
  description = "The Azure region where the Azure Resources will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Azure Resources."
  type        = map(string)
  default     = {}
}

variable "new_web_app_resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Windows Web App should exist."
}

variable "name_config" {
  type = object({
    web_app_resource_group_creation         = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_resource_group_creation = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_creation                = string //"Flag to indicate whether a new Virtual Network should be created or existing Virtual Network is used."
    subnet_creation                         = string //"Flag to indicate whether a new Subnet should be created or existing Subnet is used."
    environment                             = string //Deployment Environment (for example UAT or Prod).
    short_name                              = string //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name                            = string //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag                             = string //Central US (cus), East US 2 (eus2)
    instance                                = string //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    application                             = string //web, app, data, logs, mgmt, appvm, appserv, sqlvm, sqlmi
  })
}

variable "app_service_mapping" {
  description = "A map defining App Service Plans and their specific configurations, including their associated Web Apps and their individual site_config and app_settings."
  type = map(object({
    config = object({
      sku_name                        = string           //(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I1mv2, I2v2, I2mv2, I3v2, I3mv2, I4v2, I4mv2, I5v2, I5mv2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3, and Y1.
      os_type                         = string           //(Required) The O/S type for the App Services to be hosted in this plan. Possible values are Windows, Linux, and WindowsContainer.
      maximum_elastic_worker_count    = optional(number) //(Optional) The maximum number of workers to use in an Elastic SKU Plan or Premium Plan that have premium_plan_auto_scale_enabled set to true.
      worker_count                    = optional(number) //(Optional) The number of Workers (instances) to be allocated. Defaults to 1 if not specified and the SKU allows it.
      per_site_scaling_enabled        = optional(bool)   //(Optional) Should Per Site Scaling be enabled. Defaults to false.
      premium_plan_auto_scale_enabled = optional(bool)   //(Optional) Should automatic scaling be enabled for the Premium SKU Plan. Defaults to false. Cannot be set unless using a Premium SKU.
      zone_balancing_enabled          = optional(bool)   //(Optional) Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created.  
    })
    web_apps = list(object({
      name = string
      site_config = optional(object({
        ftps_state             = optional(string) //(Optional) The State of FTP / FTPS service. Possible values include: AllAllowed, FtpsOnly, Disabled.
        minimum_tls_version    = optional(string) //(Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
        use_32_bit_worker      = optional(bool)   //(Optional) Should the Windows Web App use a 32-bit worker. Defaults to true.
        vnet_route_all_enabled = optional(bool)   //(Optional) Should all outbound traffic to have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to false.
        worker_count           = optional(number) //(Optional) The number of Workers for this Windows App Service.

        application_stack = optional(list(object({
          dotnet_version               = optional(string) //(Optional) The version of .NET to use when current_stack is set to dotnet. Possible values include v2.0,v3.0, v4.0, v5.0, v6.0 and v7.0.
          current_stack                = optional(string) //(Optional) The Application Stack for the Windows Web App. Possible values include dotnet, dotnetcore, node, python, php, and java.
          dotnet_core_version          = optional(string) //(Optional) The version of .NET to use when current_stack is set to dotnetcore. Possible values include v4.0.
          java_embedded_server_enabled = optional(bool)   //(Optional) Should the Java Embedded Server (Java SE) be used to run the app.
          java_version                 = optional(string) //(Optional) The version of Java to use when current_stack is set to java.
          node_version                 = optional(string) //(Optional) The version of node to use when current_stack is set to node. Possible values are ~12, ~14, ~16, and ~18.
          php_version                  = optional(string) //(Optional) The version of PHP to use when current_stack is set to php. Possible values are 7.1, 7.4 and Off.
          python                       = optional(bool)   //(Optional) Specifies whether this is a Python app. Defaults to false.
        })))
      }))
      app_settings = optional(map(string))          //A map of App Settings to apply to the Windows Web App.
      web_app_slots = optional(list(object({        // A list of Web App Slots to deploy in Windows Web App.
        name = string                               //Name of the Web App Slot.
        slot_site_config = optional(object({        //A map of Site Configs to apply to the Windows Web App Slot.
          ftps_state             = optional(string) //(Optional) The State of FTP / FTPS service. Possible values include: AllAllowed, FtpsOnly, Disabled.
          minimum_tls_version    = optional(string) //(Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
          use_32_bit_worker      = optional(bool)   //(Optional) Should the Windows Web App use a 32-bit worker. Defaults to true.
          vnet_route_all_enabled = optional(bool)   //(Optional) Should all outbound traffic to have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to false.
          worker_count           = optional(number) //(Optional) The number of Workers for this Windows App Service.

          application_stack = optional(list(object({
            dotnet_version               = optional(string) //(Optional) The version of .NET to use when current_stack is set to dotnet. Possible values include v2.0,v3.0, v4.0, v5.0, v6.0 and v7.0.
            current_stack                = optional(string) //(Optional) The Application Stack for the Windows Web App. Possible values include dotnet, dotnetcore, node, python, php, and java.
            dotnet_core_version          = optional(string) //(Optional) The version of .NET to use when current_stack is set to dotnetcore. Possible values include v4.0.
            java_embedded_server_enabled = optional(bool)   //(Optional) Should the Java Embedded Server (Java SE) be used to run the app.
            java_version                 = optional(string) //(Optional) The version of Java to use when current_stack is set to java.
            node_version                 = optional(string) //(Optional) The version of node to use when current_stack is set to node. Possible values are ~12, ~14, ~16, and ~18.
            php_version                  = optional(string) //(Optional) The version of PHP to use when current_stack is set to php. Possible values are 7.1, 7.4 and Off.
            python                       = optional(bool)   //(Optional) Specifies whether this is a Python app. Defaults to false.
          })))
        }))
        slot_app_settings                  = optional(map(string)) //A map of App Settings to apply to the Windows Web App Slot.
        slot_public_network_access_enabled = optional(bool)        // Is Public Network Access enabled for the Windows Web App Slot.
        enable_application_insights        = optional(bool)        //(Optional) Controls whether Application Insights is enabled/created. Set to true to enable, false to disable. Defaults to true.
        slot_vnet_integration_enable       = optional(bool)        //To determine whether VNet integration is enabled for Web App Slot. If false, virtual_network_subnet_id will be null.
      })))
    }))
  }))
}

variable "public_network_access_enabled" {
  description = "Is Public Network Access enabled for the Windows Web App."
  type        = bool
}

variable "enable_private_dns_zone_group" {
  description = "Whether to enable the private DNS zone group."
  type        = bool
}

variable "web_app_private_dns_zone_id" {
  description = "A list of private DNS zone IDs for Web App."
  type        = list(string)
  default     = null
}

variable "web_app_vnet_integration_enable" {
  type        = bool
  description = "To determine whether VNet integration is enabled for Web Apps. If false, virtual_network_subnet_id will be null."
}

variable "existing_resource_group_web_app_name" {
  type        = string
  description = "Name of the Existing Resource Group in which Web App is to be created."
}

variable "existing_resource_group_virtual_network_name" {
  type        = string
  description = "Name of the Existing Resource Group in which Virtual Network is created."
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

variable "enable_application_insights" {
  description = "(Optional) Controls whether Application Insights is enabled/created. Set to true to enable, false to disable. Defaults to true."
  type        = bool
}

variable "application_insights_workspace_id" {
  type        = string
  description = "(Optional) Specifies the id of a log analytics workspace resource."
}

variable "application_insights_application_type" {
  type        = string
  description = "(Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure."

  validation {
    condition     = contains(["ios", "java", "MobileCenter", "Node.JS", "other", "phone", "store", "web"], var.application_insights_application_type)
    error_message = "The application_type must be one of 'ios', 'java', 'MobileCenter', 'Node.JS', 'other', 'phone', 'store', or 'web'."
  }
}

variable "application_insights_retention_in_days" {
  type        = number
  description = "(Optional) Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
}
