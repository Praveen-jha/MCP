# Defines a role assignment, specifying the scope, role definition, and principal, either by ID or name.
resource "azurerm_role_assignment" "rbac" {
  scope                            = var.scope
  role_definition_name             = var.role_definition_name
  principal_id                     = var.principal_id
  role_definition_id               = var.role_definition_id
  skip_service_principal_aad_check = var.skip_service_principal_aad_check
}
