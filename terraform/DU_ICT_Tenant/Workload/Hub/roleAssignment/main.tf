# ......................................................
# Creating Role Assignment Storage Blob Data Contributor
# ......................................................

module "role_assignment_sa" {
  count                = length(local.principal_id_sa)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.sa_role_name
  scope                = var.storage_account_id
  principal_id         = element(local.principal_id_sa, count.index)
}

# ......................................................
# Creating Role Assignment for monitoring contributor
# ......................................................

module "role_assignment_monitoring" {
  count                = length(local.monitoring_principal_id)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.monitoring_role_name
  scope                = "/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08"
  principal_id         = element(local.monitoring_principal_id, count.index)
}

# ......................................................
# Creating Role Assignment for contributor
# ......................................................

module "role_assignment_contributor" {
  count                = length(local.contributor_principal_id)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.contributor_role_name
  scope                = "/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08"
  principal_id         = element(local.contributor_principal_id, count.index)
}

# ......................................................
# Creating Role Assignment for Owner
# ......................................................

module "role_assignment_owner" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.owner_role_name
  scope                = "/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08"
  principal_id         = local.owner_principal_id
}
