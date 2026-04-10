location = "CentralUS"

tags = {
  environment = "dev"
}

new_web_app_resource_group_name = "rg-mr-crm-dev-cus-01a"

name_config = {
  web_app_resource_group_creation         = "new"
  virtual_network_resource_group_creation = "existing"
  virtual_network_creation                = "existing"
  subnet_creation                         = "existing"
  environment                             = "dev"
  short_name                              = "mr"
  product_name                            = "crm"
  region_flag                             = "cus"
  instance                                = "01"
  application                             = "web"
}

app_service_mapping = {
  "Pod1t" = {
    config = {
      sku_name                        = "P1v2"
      os_type                         = "Windows"
      maximum_elastic_worker_count    = 20
      worker_count                    = 2
      per_site_scaling_enabled        = true
      premium_plan_auto_scale_enabled = true
      zone_balancing_enabled          = true
    }
    web_apps = [
      {
        name = "Evo2ty"
        site_config = {
          use_32_bit_worker   = false
          minimum_tls_version = "1.2"
          worker_count        = 1
          ftps_state          = "FtpsOnly"
          application_stack = [
            {
              dotnet_version = "v9.0"
              php_version    = "Off"
              current_stack  = "dotnet"
            }
          ]
        }
        app_settings = {
          "WEBSITE_STACK" = "dotnet"
        }
        web_app_slots = [
          {
            name         = "staging"
            slot_app_settings = { "WEBSITE_STACK" = "dotnet" }
            slot_site_config = {
              use_32_bit_worker   = false
              minimum_tls_version = "1.2"
              worker_count        = 1
              ftps_state          = "FtpsOnly"
              application_stack = [
                {
                  dotnet_version = "v9.0"
                  php_version    = "Off"
                  current_stack  = "dotnet"
                }
              ]
            }
            slot_public_network_access_enabled = true
            slot_vnet_integration_enable       = false
            enable_application_insights        = true
          }
        ]
      },
      {
        name = "Deskingty"
        site_config = {
          use_32_bit_worker   = false
          minimum_tls_version = "1.2"
          worker_count        = 1
          ftps_state          = "FtpsOnly"
          application_stack = [
            {
              dotnet_version = "v9.0"
              php_version    = "Off"
              current_stack  = "dotnet"
            }
          ]
        }
        app_settings = {
          "WEBSITE_STACK" = "dotnet"
        }
        web_app_slots = [
          {
            name         = "staging"
            slot_app_settings = { "WEBSITE_STACK" = "dotnet" }
            slot_site_config = {
              use_32_bit_worker   = false
              minimum_tls_version = "1.2"
              worker_count        = 1
              ftps_state          = "FtpsOnly"
              application_stack = [
                {
                  dotnet_version = "v9.0"
                  php_version    = "Off"
                  current_stack  = "dotnet"
                }
              ]
            }
            slot_public_network_access_enabled = false
            slot_vnet_integration_enable       = false
            enable_application_insights        = true
          },
          {
            name         = "staging2"
            slot_app_settings = { "WEBSITE_STACK" = "dotnet" }
            slot_site_config = {
              use_32_bit_worker   = false
              minimum_tls_version = "1.2"
              worker_count        = 1
              ftps_state          = "FtpsOnly"
              application_stack = [
                {
                  dotnet_version = "v9.0"
                  php_version    = "Off"
                  current_stack  = "dotnet"
                }
              ]
            }
            slot_public_network_access_enabled = true
            slot_vnet_integration_enable       = true
            enable_application_insights        = false
          }
        ]
      },
      {
        name = "OnPointtyz"
        site_config = {
          use_32_bit_worker   = false
          minimum_tls_version = "1.2"
          worker_count        = 1
          ftps_state          = "FtpsOnly"
          application_stack = [
            {
              dotnet_version = "v9.0"
              php_version    = "Off"
              current_stack  = "dotnet"
            }
          ]
        }
        app_settings = {
          "WEBSITE_STACK" = "dotnet"
        }
        web_app_slots = []
      }
    ]
  }
}

web_app_vnet_integration_enable = false

public_network_access_enabled = true
enable_private_dns_zone_group = true

web_app_private_dns_zone_id = [""]

existing_resource_group_web_app_name         = "" //Not required if deploying new Resource Group
existing_resource_group_virtual_network_name = "rg-mr-crm-dev-vnet-cus-01"
existing_virtual_network_name                = "vnet-mr-crm-dev-cus-01"
existing_private_endpoint_subnet_name        = "snet-mr-crm-dev-pep-cus-01"
existing_outbound_subnet_name                = "snet-mr-crm-dev-web-cus-01"

enable_application_insights            = false
application_insights_workspace_id      = ""
application_insights_application_type  = "web"
application_insights_retention_in_days = 90
