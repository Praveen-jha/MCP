output "automationAccountName" {
  value = azurerm_automation_account.automationAccount.name
}
output "automationAccountId" {
  value = azurerm_automation_account.automationAccount.id
}

output "automationAccountSystemAssignedIdentity" {
  value = azurerm_automation_account.automationAccount.identity[0].principal_id
}
