# deployment.tfvars
# Variable values for Key Vault Objects workload with multiple Key Vaults

# Multiple Key Vault configurations
kv_objects = {
  "keyvault-01" = {
    kv_name    = "kv-cdk-crm"
    kv_rg_name = "rg-mr-crm-dev-cus-01"
    
    # Key definitions for this Key Vault
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
            "signing-key-02" = {
        key_opts                             = ["sign", "verify"]
        key_type                             = "RSA"
        key_size                             = 2048
        available_rotation_policy            = false
        rotation_policy_time_before_expiry   = null
        rotation_policy_expire_after         = null
        rotation_policy_notify_before_expiry = null
      }
    }
    
    # Secret definitions for this Key Vault
    secret_definitions = {
      "database-connection-string" = {
        secret_value = "Server=myserver1;Database=mydb1;User=myuser1;Password=mypass1;"
      }
      "api-key-external-service" = {
        secret_value = "sk-1234567890abcdef"
      }
      "secretdata-for-appgw-backend" = {
        secret_value = "backend-secret-data-kv1"
      }
            "secretdata-for-appgw-backend1" = {
        secret_value = "backend-secret-data-kv1"
      }
    }
    
    # Certificate configuration for this Key Vault
    certificate_name     = "crm-connectcdk-com"
    certificate_content  = "certificate-to-import1.pfx"
    certificate_password = "cert_password_123"
  }
  
  "keyvault-02" = {
    kv_name    = "kv-cdk-crm"
    kv_rg_name = "rg-mr-crm-dev-cus-01"
    
    # Key definitions for this Key Vault
    key_definitions = {
      "encryption-key-02" = {
        key_opts                             = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
        key_type                             = "RSA"
        key_size                             = 4096
        available_rotation_policy            = true
        rotation_policy_time_before_expiry   = "P45D"
        rotation_policy_expire_after         = "P120D"
        rotation_policy_notify_before_expiry = "P44D"
      }
      "backup-key-01" = {
        key_opts                             = ["decrypt", "encrypt"]
        key_type                             = "RSA"
        key_size                             = 2048
        available_rotation_policy            = false
        rotation_policy_time_before_expiry   = null
        rotation_policy_expire_after         = null
        rotation_policy_notify_before_expiry = null
      }
    }
    
    # Secret definitions for this Key Vault
    secret_definitions = {
      "database-connection-string" = {
        secret_value = "Server=myserver2;Database=mydb2;User=myuser2;Password=mypass2;"
      }
      "storage-account-key" = {
        secret_value = "DefaultEndpointsProtocol=https;AccountName=storage2;"
      }
      "app-config-secret" = {
        secret_value = "app-config-data-kv2"
      }
    }
    
    # Certificate configuration for this Key Vault
    certificate_name     = "app-backup-com"
    certificate_content  = "certificate-to-import1.pfx"
    certificate_password = "cert_password_456"
  }
}