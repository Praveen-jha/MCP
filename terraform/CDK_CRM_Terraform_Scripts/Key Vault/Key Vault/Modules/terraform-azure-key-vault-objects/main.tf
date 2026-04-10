# main.tf
# Reference Links: https://registry.terraform.io/providers/hashicorp/azurerm/4.29.0/docs/resources/key_vault_certificate
# Reference Links: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
# Reference Links: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate

# # Key Vault Keys - Uses for_each to create multiple keys
resource "azurerm_key_vault_key" "key_vault_key" {

  for_each     = var.key_definitions
  key_opts     = each.value.key_opts
  key_type     = each.value.key_type
  key_size     = each.value.key_size
  key_vault_id = var.key_vault_id
  name         = each.key

  dynamic "rotation_policy" {
    for_each = each.value.available_rotation_policy == false ? [] : [1]
    content {
      automatic {
        time_before_expiry = each.value.rotation_policy_time_before_expiry
      }
      expire_after         = each.value.rotation_policy_expire_after
      notify_before_expiry = each.value.rotation_policy_notify_before_expiry
    }
  }
}

# Key Vault Secrets - Uses for_each to create multiple secrets
resource "azurerm_key_vault_secret" "key_vault_secret" {
  depends_on = [azurerm_key_vault_key.key_vault_key]

  for_each     = var.secret_definitions
  name         = each.key
  value        = each.value.secret_value
  key_vault_id = var.key_vault_id

}


#Key Vault Certificates - Uses for_each to create multiple keys
resource "azurerm_key_vault_certificate" "import_certificate" {
  name         = var.certificate_name
  key_vault_id = var.key_vault_id

  certificate {
    contents = var.certificate_content
    password = var.certificate_password
  }
  depends_on = [azurerm_key_vault_secret.key_vault_secret]
}
