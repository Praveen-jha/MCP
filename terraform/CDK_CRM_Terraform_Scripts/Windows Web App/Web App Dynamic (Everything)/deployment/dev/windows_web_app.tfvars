
location = "CentralUS"

tags = {
  environment = "dev"
}

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

network = {
  address_space_vnet                     = [""]
  private_endpoint_subnet_address_prefix = [""]
  outbound_subnet_address_prefix         = [""]
  private_endpoint_subnet_application    = "pep"
  outbound_subnet_application            = "web"
}

app_service_plan_sku_name = "S2"
app_service_plan_os_type  = "Windows"

outbound_subnet_delegation = {
  subnet_delegation_name  = "outbound-delegation"
  service_delegation_name = "Microsoft.Web/serverFarms"
  actions                 = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
}

public_network_access_enabled = false

windows_web_app_site_config = [
  {
    always_on                      = true
    http2_enabled                  = true
    use_32_bit_worker              = false
    minimum_tls_version            = "1.2"
    scm_type                       = "GitHub"
    websockets_enabled             = true
    worker_count                   = 1
    default_documents              = []
    detailed_error_logging_enabled = true
    ftps_state                     = "FtpsOnly"
    application_stack = [
      {
        dotnet_version = "v9.0"
        php_version    = "Off"
        current_stack  = "dotnet"
      }
    ]
    auto_heal_setting  = []
    cors               = []
    ip_restriction     = []
    scm_ip_restriction = []
  }
]

existing_resource_group_name          = "rg-mr-crm-dev-cus-01"
existing_virtual_network_name         = "vnet-mr-crm-dev-cus-01"
existing_private_endpoint_subnet_name = "snet-mr-crm-dev-pep-cus-01"
existing_outbound_subnet_name         = "snet-mr-crm-dev-web-cus-01"
