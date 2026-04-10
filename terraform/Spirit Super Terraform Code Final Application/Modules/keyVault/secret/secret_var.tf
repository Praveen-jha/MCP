variable "secretName" {
   type = string
   default = "secret01"
   description = "Key Vault Secret name."
}

variable "secretValue" {
   type = string
   default = "null"
   description = "Key Vault Secret Value."
}

variable "kvId" {
   type = string
   default = ""
   description = "Resource Id of Key Vault."
}

variable "contentType" {
  type = string
  description = "Key Vault Secret Content Type."
}

variable "expirationDate" {
  type = string
  description = "Key Vault Secret Expiration Date."
}
