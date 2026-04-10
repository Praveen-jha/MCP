output "ingestionStorageID" {
  value = jsondecode(azurerm_resource_group_template_deployment.purview_account.output_content).ingestionStorageID.value
}
