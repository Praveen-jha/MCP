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
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }
  tags = var.openai_tags
}

#Resource Block for Azure OpenAI ptu model
resource "azapi_resource" "gpt-4o-2024-05-13" {
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
}

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
