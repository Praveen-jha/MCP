# Inbound Policy per API — set a header
# ————————————————————————————————————————————————————————————————
resource "azurerm_api_management_api_policy" "inbound_set_header" {
  for_each = {
    for k, v in var.apis :
    k => v if v.create_policy
  }
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name
  api_name            = azurerm_api_management_api.apis[each.key].name


  xml_content = <<-XML
    <policies>
      <inbound>
        <base />
        <set-header name="${var.inbound_header_name}" exists-action="${var.inbound_header_exists_action}">
          <value>${var.inbound_header_value}</value>
        </set-header>
      </inbound>
      <backend>
        <base />
      </backend>
      <outbound>
        <base />
      </outbound>
      <on-error>
        <base />
      </on-error>
    </policies>
  XML
}
