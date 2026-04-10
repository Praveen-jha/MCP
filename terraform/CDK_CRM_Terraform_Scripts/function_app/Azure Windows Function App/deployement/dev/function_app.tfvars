# Resource Group Configuration
resource_group_name     = "rg-functionapp-dev"
resource_group_location = "East US"

# Tags
tags = {
  environment = "development"
}

# Storage Account Configuration

account_tier               = "Standard"
account_replication_type   = "LRS"
account_kind              = "StorageV2"

# App Service Plan Configuration

os_type              = "Windows"
sku_name             = "Y1"  # Consumption plan for Functions

# Function App Configuration
name_config = {
  resource_group_creation  = "existing"
  virtual_network_creation = "existing"
  subnet_creation          = "existing"
  environment              = "dev"
  short_name               = "mr"
  product_name             = "crm"
  region_flag              = "cus"
  instance                 = "01"
  application              = "web"
}
web_app_vnet_integration_enable = true  # Enable VNet integration for the Function App

public_network_access_enabled = false  # Set to true if public network access is enabled
enable_private_dns_zone_group = true

private_dns_zone_id = ["/subscriptions/0c267d19-0a1d-449d-8f6d-88536cb2f4ca/resourceGroups/rg-mr-crm-dev-cus-02/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"]

existing_resource_group_name          = "rg-mr-crm-dev-cus-02"
existing_virtual_network_name         = "vnet-mr-crm-dev-cus-02"
existing_private_endpoint_subnet_name = "snet-mr-crm-dev-pep-cus-02"
existing_outbound_subnet_name         = "snet-mr-crm-dev-web-cus-02"
