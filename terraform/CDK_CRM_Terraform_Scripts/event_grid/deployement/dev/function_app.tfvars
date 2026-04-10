# Resource Group Configuration
resource_group_name     = ""
resource_group_location = "" # Azure region for the resource group

# Tags
tags = {
  environment = "development"
}
# Naming Configuration
# This configuration is used to generate consistent resource names across the deployment
name_config = {
  resource_group_creation  = "existing"
  virtual_network_creation = "existing"
  subnet_creation          = "existing"
  storage_account_creation = "existing"
  function_app_creation    = "existing"
  environment              = "dev"
  short_name               = "mr"
  product_name             = "crm"
  region_flag              = "cus"
  instance                 = "01"
  application              = "eventgrid"
}

# Existing Resource Group Configuration
existing_resource_group_name          = "ssis-test-rg"
existing_virtual_network_name         = "ssis-test-vnet"
existing_private_endpoint_subnet_name = "ssis-subnet"
existing_outbound_subnet_name         = "ssisweb-subnet"
existing_function_app_name            = "cdktestfucappwe"

# EventGrid System Topic configuration (required)
source_arm_resource_id = ""
topic_type             = "Microsoft.Storage.StorageAccounts"

# Endpoint configuration (required)
endpoint_type = "webhook" # Options: "storage_queue", "azure_function", "webhook"

webhook_endpoint = {
  url = "https://cdktestfucappwe-gpe2b4hyfdg5fthn.centralus-01.azurewebsites.net"  # Change this to your actual webhook or function endpoint
  # Optionally, add batching/AAD keys if needed
}

# All other parameters will use their default null values unless specified
# Optional: Override specific parameters when needed
# event_delivery_schema = "EventGridSchema"
# included_event_types = ["Microsoft.Storage.BlobCreated"]
# subject_filter = {
#   subject_begins_with = "/blobServices/default/containers/images/"
# }
