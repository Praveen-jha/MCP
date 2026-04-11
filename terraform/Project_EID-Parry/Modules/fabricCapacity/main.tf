resource "azurerm_fabric_capacity" "fabric_capacity" {
  name                   = var.fabric_cap_name
  resource_group_name    = var.fabric_cap_rg_name
  location               = var.fabric_cap_location
  administration_members = var.fabric_cap_administration_members
  sku {
    name = var.fabric_cap_sku
    tier = "Fabric"
  }
  tags = var.fabric_cap_tags
  lifecycle {
    ignore_changes = [
      sku,
      administration_members,
      tags
    ]
    prevent_destroy = true
  }
}