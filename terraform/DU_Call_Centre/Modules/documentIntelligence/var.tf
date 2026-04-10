// REQUIRED VARIABLES (variables which are needed to be passed)
variable "document_intelligence_name" {
  description = "The name of the Document Intelligence Cognitive Service"
  type        = string
}
variable "rgName" {
  description = "The name of the Azure resource group where the Document Intelligence Cognitive Service will be created"
  type        = string
}
variable "location" {
  description = "The Azure region where the Document Intelligence Cognitive Service will be deployed"
  type        = string
}
variable "diKind" {
  description = "The kind of the Document Intelligence Cognitive Service"
  type        = string
}
variable "diSkuName" {
  description = "The SKU (pricing tier) for the Document Intelligence Cognitive Service"
  type        = string
}

// OPTIONAL VARIABLES (variables which are not necessary to be passed)
variable "diTags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}
variable "diCustomSubdomain" {
  description = "The subdomain name used for token-based authentication"
  type        = string
}
variable "publiceNetworkAccessEnabled" {
  description = "Defines whether public network access is allowed or not"
  type        = bool
}
variable "identityType" {
  description = "It specifies the type of Managed Service Identity that should be configured"
  type        = string
}

variable "user_assigned_identity_id" {
  description = "User assigned identity"
  type = string
}

variable "key_vault_key_id" {
  description = "key Vault key ID"
  type = string
}

variable "identity_ids" {
  description = "user or system assinged ID"
  type = set(string)
}