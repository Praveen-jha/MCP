# main.tf
# --- APIM Resource and its dependencies ---
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management#argument-reference
resource "azurerm_api_management" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  publisher_name                = var.publisher_name
  publisher_email               = var.publisher_email
  sku_name                      = var.sku_name
  public_ip_address_id          = var.public_ip_required ? data.azurerm_public_ip.existing[0].id : null
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_type          = var.virtual_network_type

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_type != "None" ? ["virtual_network_configuration"] : []
    content {
      subnet_id = data.azurerm_subnet.existing[0].id
    }
  }
  tags  = var.tags
  zones = var.availability_zone ? var.zones : null
}
