subscription_id     = ""
hub_subscription_id = ""

prefix                        = "cdk-mr-dev"
name                          = ""
resource_group_name           = ""
network_resource_group        = ""
subnet_name                   = ""
virtual_network_name          = ""
public_ip_name                = null
location                      = "Central US"
publisher_name                = ""
publisher_email               = ""
sku_name                      = "Developer_1"
identity_type                 = "SystemAssigned"
availability_zone             = false
zones                         = null
public_network_access_enabled = true
virtual_network_type          = "Internal"

enable_private_endpoint      = false
create_private_dns_record    = false
private_dns_zone_rg_name     = ""
private_zone_domain          = ""
public_ip_required           = false
private_endpoint_subnet_name = null

enable_diagnostic               = false
enable_defender_for_apis        = false
app_insight_enabled             = false
log_analytics_workspace_enabled = false


# Example API map
apis = {
  #   "inventory-api1" = {
  #     display_name = "Inventory API"
  #     path         = "inventory"
  #     service_url  = "https://backend.contoso.com/inventory"
  #     revision     = "1"
  #     protocols    = ["https"]
  #     create_policy = false
  #   }
}


# Products and which APIs each includes
products = {
  #   gold = {
  #     display_name        = "Gold Product"
  #     description         = "Premium access"
  #     approval_required   = false
  #     subscriptions_limit = 1000
  #     published           = true
  #     terms               = "Use responsibly."
  #     apis                = ["inventory-api1"]
  #   }
}

# Custom Groups
groups = {
  #   internal = {
  #     display_name = "Internal Team"
  #     description  = "Employees"
  #   }
}

# Which groups attach to which products
product_groups = {
  #   gold = ["internal"]
}

# Users and which groups they join
users = {
  #   abi = {
  #     first_name = ""
  #     last_name  = ""
  #     email      = "abc@example.com"
  #     password   = "ChangeM3!"
  #     groups     = ["internal"]
  #   }
}

# Subscriptions
subscriptions = {
  #   abi_gold = {
  #     display_name = "Gold Sub"
  #     product_key  = "gold"
  #     user_key     = "abc"
  #   }
}

subscription_pricing = {
  #   tier          = "Standard"
  #   subplan       = "P1"
  #   resource_type = "Api"
}

tags = {
}
