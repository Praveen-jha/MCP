resource "azurerm_cognitive_account" "aoai" {
  name                          = var.Cognitive_account_Name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kind                          = var.kind
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  custom_subdomain_name         = var.custom_subdomain_name

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? [] : var.user_assigned_identity_id
  }

  lifecycle {
    ignore_changes = all
  }
  # tags                          = var.openai_tags
}

resource "azurerm_cognitive_account_customer_managed_key" "cmk" {
  cognitive_account_id = azurerm_cognitive_account.aoai.id
  key_vault_key_id     = var.key_vault_key_id
  identity_client_id   = var.user_assigned_identity_clientid
  depends_on           = [azurerm_cognitive_account.aoai]
}

#Resource Block for Azure OpenAI ptu model
resource "azapi_resource" "gpt-4o-2024-08-06" {
  type      = "Microsoft.CognitiveServices/accounts/deployments@2023-05-01"
  name      = var.deployment_name
  parent_id = azurerm_cognitive_account.aoai.id

  body = {
    sku = {
      name     = var.ptu_sku_name
      capacity = var.ptu_sku_capacity
    },
    properties = {
      model = {
        format  = var.model_format
        name    = var.model_name
        version = var.model_version
      }
    }
  }
  # lifecycle {
  #   ignore_changes = [
  #     body["sku"]["capacity"],
  #     body["properties"]["model"]["version"]
  #   ]
  # }
}

# resource "azapi_resource" "gpt-4o-2024-11-20" {
#   type      = "Microsoft.CognitiveServices/accounts/deployments@2023-05-01"
#   name      = var.latest_deployment_name
#   parent_id = azurerm_cognitive_account.aoai.id

#   body = {
#     sku = {
#       name     = var.latest_ptu_sku_name
#       capacity = var.latest_ptu_sku_capacity
#     },
#     properties = {
#       model = {
#         format  = var.latest_model_format
#         name    = var.latest_model_name
#         version = var.latest_model_version
#       }
#     }
#   }
# }

#Resource Block for Azure OpenAI Embedding model
resource "azapi_resource" "aoai_embedding_model" {
  type      = "Microsoft.CognitiveServices/accounts/deployments@2023-05-01"
  name      = var.embedding_deployment_name
  parent_id = azurerm_cognitive_account.aoai.id

  body = {
    sku = {
      name     = var.embedding_sku_name
      capacity = var.embedding_sku_capacity
    },
    properties = {
      model = {
        format  = var.model_format
        name    = var.embedding_model_name
        version = var.embedding_model_version
      }
    }
  }
}
