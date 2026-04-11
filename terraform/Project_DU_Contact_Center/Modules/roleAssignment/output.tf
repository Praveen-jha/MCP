output "azurerm_role_assignment" {
    description = "Output: Azure role assignment resource object"
    value       = azurerm_role_assignment.rbac.principal_id
}
