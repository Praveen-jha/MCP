subscription_id = ""

prefix   = ""
location = "centralus"

tags = {
}

account_tier = "Standard"

account_replication_type = "LRS"

storage_account_name = ""

storage_container_name = ""

network_rules = {
  default_action             = "Deny"            # Must be "Deny" or "Allow"
  bypass                     = ["AzureServices"] # Optional: Can include "Logging", "Metrics", "AzureServices", or "None"
  ip_rules                   = ["", ""]          # Optional: List of public IPs or IP ranges in CIDR format
  virtual_network_subnet_ids = []                # Optional: List of Azure VNet Subnet Resource IDs (e.g., "/subscriptions/xxx/resourceGroups/yyy/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1")
}
