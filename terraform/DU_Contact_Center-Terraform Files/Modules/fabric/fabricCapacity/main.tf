# terraform {
#   required_providers {
#     azapi = {
#       source  = "Azure/azapi"
#       version = "2.2.0"
#     }
#   }
# }

# provider "azapi" {
# }

# resource "azapi_resource" "fabric_capacity" {
#   type                      = "Microsoft.Fabric/capacities@2023-11-01"
#   name                      = var.fabric_capacity_name
#   location                  = var.fabric_location
#   parent_id = var.resource_group_id
#   tags = var.fabric_tags
 
#   body = {
#     sku = {
#       name = var.fabric_capacity_sku_name
#       tier = var.fabric_capacity_sku
#     }
#     properties = {
#       administration = {
#         members = [
#           var.fabric_capacity_admin
#         ]
#       }
#     }
#   }
# }




resource "azurerm_fabric_capacity" "fabric_capacity" {
  name                   = var.fabric_capacity_name
  resource_group_name    = var.fabric_cap_rg_name
  location               = var.fabric_location
  administration_members = [var.fabric_capacity_admin]
  sku {
    name = var.fabric_capacity_sku_name
    tier = var.fabric_capacity_tier
  }
  tags = var.fabric_tags
  lifecycle {
    ignore_changes = [
      sku,
      administration_members,
      tags
    ]
  }
}