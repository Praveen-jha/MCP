# ......................................................
# Creating Role Assignment for key vault
# ......................................................

module "role_assignment_kv_secrets_officer" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_secrets_officer_role_name
  scope                = data.azurerm_key_vault.kv.id
  principal_id         = data.azurerm_client_config.current.object_id
  depends_on           = [module.role_assignment_kv_access_admin]
}

# ......................................................
# Creating Role Assignment for key vault
# ......................................................

module "role_assignment_kv_access_admin" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_access_admin_role_name
  scope                = data.azurerm_key_vault.kv.id
  principal_id         = data.azurerm_client_config.current.object_id
}

# ......................................................
# Creating Role Assignment for key vault
# ......................................................

module "role_assignment_kv_secret_user" {
  count                = length(local.kv_secret_user_principal_id)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_secret_user_role_name
  scope                = data.azurerm_key_vault.kv.id
  principal_id         = element(local.kv_secret_user_principal_id, count.index)
  depends_on           = [module.role_assignment_kv_access_admin]
}

# ......................................................
# Creating Role Assignment for monitoring contributor
# ......................................................

module "role_assignment_monitoring" {
  count                = length(local.monitoring_principal_id)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.monitoring_role_name
  scope                = "/subscriptions/23c04f75-916a-4128-ae5c-d0e2a5c1d89f"
  principal_id         = element(local.monitoring_principal_id, count.index)
}

# ......................................................
# Creating Role Assignment for contributor
# ......................................................

module "role_assignment_contributor" {
  count                = length(local.contributor_principal_id)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.contributor_role_name
  scope                = "/subscriptions/23c04f75-916a-4128-ae5c-d0e2a5c1d89f"
  principal_id         = element(local.contributor_principal_id, count.index)
}

# ......................................................
# Creating Role Assignment for Owner
# ......................................................

module "role_assignment_owner" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.owner_role_name
  scope                = "/subscriptions/23c04f75-916a-4128-ae5c-d0e2a5c1d89f"
  principal_id         = local.owner_principal_id
}

# ......................................................
# Creating Role Assignment Storage Blob Data Contributor
# ......................................................

module "role_assignment_sa" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.sa_role_name
  scope                = var.storage_account_id
  principal_id         = data.azurerm_client_config.current.object_id
}

# ......................................................
# Creating Role Assignment Storage Blob Data Contributor for UAID
# ......................................................

module "role_assignment_uaid" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.sa_role_name
  scope                = var.storage_account_id
  principal_id         = data.azurerm_user_assigned_identity.uaid.principal_id
}

# ......................................................
# Creating Role Assignment Storage Blob Data Contributor
# ......................................................

module "role_assignment_sa_dev" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = "Storage Account Contributor"
  scope                = var.storage_account_id
  principal_id         = "2c7522d7-a8c1-4810-b580-08ed64f15bb2"
}
