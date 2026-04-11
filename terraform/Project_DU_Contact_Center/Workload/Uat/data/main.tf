# ......................................................
# Creating New Resource Group
# ......................................................
module "RG" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.uat_data_rg_name
  resource_group_location = var.location
  resource_group_tags     = var.resource_group_tags
}

# ......................................................
# Creating APIM
# ......................................................
module "external_apim" {
  source                        = "../../../Modules/apim"
  name                          = local.apim_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  publisher_name                = var.apim_config.publisher_name
  publisher_email               = var.apim_config.publisher_email
  sku_name                      = var.apim_config.sku_name
  public_network_access_enabled = var.apim_config.public_network_access_enabled
  virtual_network_type          = var.apim_config.virtual_network_type
  tags                          = merge(var.tags, var.apim_config.tags)
  identity                      = var.apim_config.identity
  virtual_network_configuration = {
    subnet_id = data.azurerm_subnet.apim_subnet.id
  }
}

# ......................................................
# Creating Azure Container Registry
# ......................................................
module "container_registry" {
  source                        = "../../../Modules/acr"
  container_registry_name       = local.container_registry_name
  resource_group_name           = local.resource_group_name
  location                      = local.location
  sku                           = var.container_registry.sku
  public_network_access_enabled = var.container_registry.public_network_access_enabled
  identity                      = var.container_registry.identity
  # retention_policy_in_days =
  tags                          = merge(var.tags, var.container_registry.tags)
  depends_on                    = [module.RG]
}
