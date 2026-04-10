# ......................................................
# Creating New Resource Group
# ......................................................
module "rg" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = data.azurerm_resource_group.data_rg.name
  resource_group_location = var.fabric_location
  resource_group_tags     = data.azurerm_resource_group.data_rg.tags
}

# # ......................................................
# # Creating Microsoft Fabric Capacity
# # ......................................................
module "fabric_capacity" {
  source                   = "../../../Modules/fabric/fabricCapacity"
  fabric_capacity_name     = local.fabric_capacity_name
  fabric_cap_rg_name       = data.azurerm_resource_group.data_rg.name
  fabric_capacity_admin    = var.fabric_capacity_admin
  fabric_capacity_sku      = var.fabric_capacity_sku
  fabric_capacity_sku_name = var.fabric_capacity_sku_name
  fabric_capacity_tier     = var.fabric_capacity_tier
  fabric_location          = data.azurerm_resource_group.data_rg.location
  fabric_tags              = var.fabric_tags
  resource_group_id        = data.azurerm_resource_group.data_rg.id
  depends_on               = [module.rg]
}

# ......................................................
# Creating Microsoft Fabric Workspace
# ......................................................
# module "fabric_workspace" {
#   source = "../../../Modules/fabric/fabricWorkspace"
#   workspace_name      = local.workspace_name
#   depends_on          = [module.rg, module.fabric_capacity]
# }



