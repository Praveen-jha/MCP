variable "disk_encryption_set_name" {
  description = "The name of the Disk Encryption Set"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault key used for disk encryption"
  type        = string
}

variable "identity" {
  description = "Identity configuration for Cosmos DB."
  type = object({
    type         = string
    identity_ids = list(string)
  })
}

variable "tags" {
  description = "The tags required for the resource"
  type        = map(string)
}
