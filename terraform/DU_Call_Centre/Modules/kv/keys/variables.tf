variable "key_opts" {
  description = "The options for the key."
  type        = list(string)
}

variable "key_type" {
  description = "The type of key to create."
  type        = string
}

variable "key_size" {
  description = "The size of the key in bits."
  type        = number
}

variable "key_vault_id" {
  description = "The ID of the key vault in which to create the key."
  type        = string
}

variable "key_name" {
  description = "The name of the key to create."
  type        = string
}

variable "available_rotation_policy" {
  description = "available rotation policy for key vault key"
  type        = string
  nullable    = true
  default     = null
}

variable "rotation_policy_time_before_expiry" {
  description = "The time before expiry to perform automatic rotation."
  type        = string
  default     = "P30D"
}

variable "rotation_policy_expire_after" {
  description = "The time after which the key expires."
  type        = string
  default     = "P90D"
}

variable "rotation_policy_notify_before_expiry" {
  description = "The time before expiry to notify."
  type        = string
  default     = "P29D"
}
