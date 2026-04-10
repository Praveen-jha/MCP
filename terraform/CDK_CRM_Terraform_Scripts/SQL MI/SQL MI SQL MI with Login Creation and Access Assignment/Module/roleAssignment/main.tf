resource "azuread_directory_role" "directory_readers" {
  display_name = var.display_name
}

resource "azuread_directory_role_assignment" "mi_reader" {
  role_id             = azuread_directory_role.directory_readers.object_id
  principal_object_id = var.sql_managed_instance_identity_principal_id
}
