# Creation of multiple Managed Private Endpoints for the single Data Factory
resource "azurerm_data_factory_managed_private_endpoint" "data_factory_mpe" {
  for_each           = var.existing_target_resources
  name               = "${var.data_factory_name}-pe-${each.key}"
  data_factory_id    = data.azurerm_data_factory.existing_data_factory[0].id
  target_resource_id = local.target_resource_ids[each.key]
  subresource_name   = each.value.subresource_name

}
