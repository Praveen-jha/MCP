# Defines a role assignment, specifying the scope, role definition, and principal, either by ID or name.
resource "azurerm_role_assignment" "rbac" {
  role_definition_name = var.role_definition_name
  scope                = var.scope
  principal_id         = var.principal_id
}