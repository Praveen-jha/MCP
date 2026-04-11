resource "azurerm_resource_group_template_deployment" "purview_account" {
  name                = "purview-deployment"
  resource_group_name = var.resourceGroupName
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "purview_account_name" = {
        "value" = var.purviewName
    },
    "purview_managed_rg_name" = {
        "value" = var.purviewManagedRGName
    },
    "location" = {
      "value"  = var.location
    },
    "publicNetworkAccess" = {
      "value" = var.publicNetworkEnabled
    }
  })
  template_content = <<TEMPLATE
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "purview_account_name": {
          "type": "String"
        },
        "purview_managed_rg_name": {
          "type": "String"
        },
        "location": {
          "type": "String"
        },
        "publicNetworkAccess": {
          "type": "String"
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Purview/accounts",
            "apiVersion": "2023-05-01-preview",
            "name": "[parameters('purview_account_name')]",
            "location": "[parameters('location')]",
            "sku": {
                "name": "Standard",
                "capacity": 1
            },
            "identity": {
                "type": "SystemAssigned"
            },
            "properties": {
                "cloudConnectors": {},
                "publicNetworkAccess": "[parameters('publicNetworkAccess')]",
                "managedResourcesPublicNetworkAccess": "NotSpecified",
                "managedEventHubState": "Disabled",
                "ingestionStorage": {
                    "publicNetworkAccess": "Disabled"
                },
                "managedResourceGroupName": "[parameters('purview_managed_rg_name')]"
            }
        }
    ],
    "outputs":{
        "ingestionStorageID": {
            "type": "string",
            "value": "[reference(parameters('purview_account_name')).ingestionStorage.id]"
        }
    }
}
    TEMPLATE
}
