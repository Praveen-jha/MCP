variable "password_length" {
  description = "Length of the random password"
  type        = number
  default     = 16
}

variable "secret_name" {
  description = "Name of the Key Vault secret"
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Azure Key Vault"
  type        = string
}
