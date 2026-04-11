# # ......................................................
##Creating Role Assignment for Contributor
# # ......................................................
module "role_assignment_contributor" {
  count                = length(local.contributor_principal_id)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.contributor_role_name
  scope                = var.contributor_scope
  principal_id         = element(local.contributor_principal_id, count.index)
}

# # ......................................................
##Creating Role Assignment for Key Vault Administrator
# # ......................................................
module "role_assignment_kv_admin" {
  count                = length(local.kv_admin_principal_id)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_admin_role_name
  scope                = var.kv_admin_scope
  principal_id         = element(local.kv_admin_principal_id, count.index)
}