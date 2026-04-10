# API Management API Resource
resource "azurerm_api_management_api" "apis" {
  for_each            = var.apis
  name                = each.key # e.g., "orders-api"
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name
  revision            = each.value.revision
  display_name        = each.value.display_name

  path        = each.value.path # e.g., "orders"
  protocols   = try(each.value.protocols,null) # e.g., ["https"]
  service_url = each.value.service_url # backend URL


  # Dynamic import block
  dynamic "import" {
    for_each = var.import_config != null ? [var.import_config] : []
    content {
      content_format = import.value.content_format
      content_value  = import.value.content_value

      dynamic "wsdl_selector" {
        for_each = import.value.wsdl_selector != null ? [import.value.wsdl_selector] : []
        content {
          service_name  = wsdl_selector.value.service_name
          endpoint_name = wsdl_selector.value.endpoint_name
        }
      }
    }
  }

  # Dynamic subscription_key_parameter_names block
  dynamic "subscription_key_parameter_names" {
    for_each = var.subscription_key_parameter_names != null ? [var.subscription_key_parameter_names] : []
    content {
      header = subscription_key_parameter_names.value.header
      query  = subscription_key_parameter_names.value.query
    }
  }

  # Dynamic license block
  dynamic "license" {
    for_each = var.license != null ? [var.license] : []
    content {
      name = license.value.name
      url  = license.value.url
    }
  }

  # Dynamic contact block
  dynamic "contact" {
    for_each = var.contact != null ? [var.contact] : []
    content {
      name  = contact.value.name
      url   = contact.value.url
      email = contact.value.email
    }
  }

  # Dynamic oauth2_authorization block
  dynamic "oauth2_authorization" {
    for_each = var.oauth2_authorization != null ? [var.oauth2_authorization] : []
    content {
      authorization_server_name = oauth2_authorization.value.authorization_server_name
      scope                     = oauth2_authorization.value.scope
    }
  }

  # Dynamic openid_authentication block
  dynamic "openid_authentication" {
    for_each = var.openid_authentication != null ? [var.openid_authentication] : []
    content {
      openid_provider_name         = openid_authentication.value.openid_provider_name
      bearer_token_sending_methods = openid_authentication.value.bearer_token_sending_methods
    }
  }
}
