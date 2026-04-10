# API Management Diagnostic Resource
resource "azurerm_api_management_diagnostic" "this" {
  count                    = var.enable_diagnostic ? 1 : 0
  identifier               = var.identifier
  resource_group_name      = azurerm_api_management.this.resource_group_name
  api_management_name      = azurerm_api_management.this.name
  api_management_logger_id = azurerm_api_management_logger.appinsights[count.index].id

  # Optional parameters with dynamic configuration
  always_log_errors     = var.always_log_errors
  log_client_ip         = var.log_client_ip
  verbosity             = var.verbosity
  sampling_percentage   = var.sampling_percentage
  operation_name_format = var.operation_name_format

  # Dynamic frontend_request block
  dynamic "frontend_request" {
    for_each = var.frontend_request != null ? [var.frontend_request] : []
    content {
      body_bytes     = frontend_request.value.body_bytes
      headers_to_log = frontend_request.value.headers_to_log

      dynamic "data_masking" {
        for_each = frontend_request.value.data_masking != null ? [frontend_request.value.data_masking] : []
        content {
          dynamic "query_params" {
            for_each = data_masking.value.query_params != null ? data_masking.value.query_params : []
            content {
              mode  = query_params.value.mode
              value = query_params.value.value
            }
          }

          dynamic "headers" {
            for_each = data_masking.value.headers != null ? data_masking.value.headers : []
            content {
              mode  = headers.value.mode
              value = headers.value.value
            }
          }
        }
      }
    }
  }

  # Dynamic frontend_response block
  dynamic "frontend_response" {
    for_each = var.frontend_response != null ? [var.frontend_response] : []
    content {
      body_bytes     = frontend_response.value.body_bytes
      headers_to_log = frontend_response.value.headers_to_log

      dynamic "data_masking" {
        for_each = frontend_response.value.data_masking != null ? [frontend_response.value.data_masking] : []
        content {
          dynamic "query_params" {
            for_each = data_masking.value.query_params != null ? data_masking.value.query_params : []
            content {
              mode  = query_params.value.mode
              value = query_params.value.value
            }
          }

          dynamic "headers" {
            for_each = data_masking.value.headers != null ? data_masking.value.headers : []
            content {
              mode  = headers.value.mode
              value = headers.value.value
            }
          }
        }
      }
    }
  }

  # Dynamic backend_request block
  dynamic "backend_request" {
    for_each = var.backend_request != null ? [var.backend_request] : []
    content {
      body_bytes     = backend_request.value.body_bytes
      headers_to_log = backend_request.value.headers_to_log

      dynamic "data_masking" {
        for_each = backend_request.value.data_masking != null ? [backend_request.value.data_masking] : []
        content {
          dynamic "query_params" {
            for_each = data_masking.value.query_params != null ? data_masking.value.query_params : []
            content {
              mode  = query_params.value.mode
              value = query_params.value.value
            }
          }

          dynamic "headers" {
            for_each = data_masking.value.headers != null ? data_masking.value.headers : []
            content {
              mode  = headers.value.mode
              value = headers.value.value
            }
          }
        }
      }
    }
  }

  # Dynamic backend_response block
  dynamic "backend_response" {
    for_each = var.backend_response != null ? [var.backend_response] : []
    content {
      body_bytes     = backend_response.value.body_bytes
      headers_to_log = backend_response.value.headers_to_log

      dynamic "data_masking" {
        for_each = backend_response.value.data_masking != null ? [backend_response.value.data_masking] : []
        content {
          dynamic "query_params" {
            for_each = data_masking.value.query_params != null ? data_masking.value.query_params : []
            content {
              mode  = query_params.value.mode
              value = query_params.value.value
            }
          }

          dynamic "headers" {
            for_each = data_masking.value.headers != null ? data_masking.value.headers : []
            content {
              mode  = headers.value.mode
              value = headers.value.value
            }
          }
        }
      }
    }
  }
}
