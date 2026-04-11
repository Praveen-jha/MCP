resource "azurerm_public_ip" "pip" {
  name                = var.PIP_Name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.Subnet_Allocation_Method
  sku                 = var.Subnet_Sku
  tags = var.PIP_tags
}

resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
  dns {
    proxy_enabled = var.proxy_enabled
  }
  sku = var.firewall_policy_sku
  tags = var.firewall_policy_tags

}

resource "azurerm_firewall" "firewall" {
  name                = var.Firewall_Name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.Sku_Name
  sku_tier            = var.Sku_Tier
  tags = var.firewall_tags
  ip_configuration {
    name                 = var.Ip_Configuration_name
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id

}
