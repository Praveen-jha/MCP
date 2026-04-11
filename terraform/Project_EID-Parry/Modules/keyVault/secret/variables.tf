variable "secret_name" {
  type        = string
  description = "Name of the secret to be stored in the Key Vault"
}
variable "secret_value" {
  type        = string
  description = "Value of the secret to be stored in the Key Vault"
}
variable "key_vault_id" {
  type        = string
  description = "ID of the Key Vault where the secret will be stored"
}
variable "content_type" {
  type        = string
  description = "Content Type of secret"
}
variable "expiration_date" {
  type        = string
  description = "Expiration UTC datetime (Y-m-d'T'H:M:S'Z')."
}