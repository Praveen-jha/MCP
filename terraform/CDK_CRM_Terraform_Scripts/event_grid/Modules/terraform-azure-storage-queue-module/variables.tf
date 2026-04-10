# Required variables
variable "name" {
  description = "The name of the Queue which should be created within the Storage Account"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name)) && length(var.name) >= 3 && length(var.name) <= 63
    error_message = "Queue name must be between 3 and 63 characters long and can only contain lowercase letters, numbers, and hyphens."
  }
}

variable "storage_account_name" {
  description = "Specifies the Storage Account in which the Storage Queue should exist"
  type        = string
}

# Optional variables
variable "metadata" {
  description = "A mapping of MetaData which should be assigned to this Storage Queue"
  type        = map(string)
  default     = null
}

variable "timeouts" {
  description = "Timeouts block for the Storage Queue"
  type = object({
    create = optional(string, "30m")
    read   = optional(string, "5m")
    update = optional(string, "30m")
    delete = optional(string, "30m")
  })
  default = null
}
