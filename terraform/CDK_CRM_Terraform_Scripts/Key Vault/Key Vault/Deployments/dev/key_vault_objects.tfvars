# # # terraform.tfvars
# # # Variable definitions for Key Vault Objects workload

# Key definitions
key_definitions = {
  "encryption-key-01" = {
    key_opts                             = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    key_type                             = "RSA"
    key_size                             = 2048
    available_rotation_policy            = true
    rotation_policy_time_before_expiry   = "P30D"
    rotation_policy_expire_after         = "P90D"
    rotation_policy_notify_before_expiry = "P29D"
  }
  "signing-key-01" = {
    key_opts                             = ["sign", "verify"]
    key_type                             = "RSA"
    key_size                             = 2048
    available_rotation_policy            = false
    rotation_policy_time_before_expiry   = null
    rotation_policy_expire_after         = null
    rotation_policy_notify_before_expiry = null
  }
}

# Secret definitions
secret_definitions = {
  "database-connection-string" = {
    secret_value = "Server=myserver;Database=mydb;User=myuser;Password=mypass;"
  }
  "api-key-external-service" = {
    secret_value = "sk-1234567890abcdef"
  }
  "secretdata-for-appgw-backend" = {
    secret_value = "backend-secret-data"
  }
}

# Certificate configuration
certificate_name = "crm-connectcdk-com"
certificate_content  = "certificate-to-import1.pfx"
certificate_password = "" # terraform.tfvars
# Variable values for Key Vault Objects workload

# Key Vault configuration

  key_vault_name    = "kv-mr-crm-dev-cus-01"
  key_vault_rg_name = "rg-mr-crm-dev-cus-01"




