variable "existing_frontdoor" {
  type        = bool
  description = "Configure existing frond door ?"
}

variable "cdn_fd_name" {
  type        = string
  description = "AFD Name"
}

variable "endpoint_name" {
  type        = list(string)
  description = "Name of the front dore endpoints"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the RG Must be existing"
}

variable "resource_group_location" {
  type        = string
  description = "Location for all resources."
}

variable "front_door_sku_name" {
  type        = string
  description = "The SKU for the Front Door profile. Possible values include: Standard_AzureFrontDoor, Premium_AzureFrontDoor"
  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.front_door_sku_name)
    error_message = "The SKU value must be one of the following: Standard_AzureFrontDoor, Premium_AzureFrontDoor."
  }
}

variable "routes" {
  description = "Route configuration map"
  type = map(object({
    route_name          = string
    endpoint_name       = string
    origin_group_name   = string
    origin_names        = list(string)
    custom_domain_names = list(string)
    ruleset_names       = list(string)
  }))
}


variable "use_existing_origin_group" {
  type        = bool
  description = "Does the origin group exists ?"
}

variable "use_existing_rulesets" {
  type        = bool
  description = "Does the rule set exists ?"
}

variable "use_existing_waf_policy" {
  type        = bool
  description = "Does the waf exists ?"
}

variable "use_existing_secret" {
  type        = bool
  description = "Use existing secret for domain ?"
}

variable "custom_domains" {
  description = "Map of custom domain configurations"
  type = map(object({
    host_name           = string
    cert_name           = string
    certificate_version = string
    key_vault_name      = string
    resource_group      = string
    association         = list(string)
  }))
}

variable "use_existing_certificate" {
  type        = bool
  description = "If true, use existing certificate from Key Vault"
}

variable "waf_policies" {
  description = "Map of WAF policy configurations with mode, associated domains and match patterns"
  type = map(object({
    name        = string
    mode        = string
    domain_name = string
    patterns    = list(string)
  }))
}

variable "rule_sets" {
  description = "Map of rule sets with rule name and rule configuration"
  type = map(object({
    name = string
    rules = map(object({
      order         = number
      type          = string           # "rewrite" or "redirect"
      source        = optional(string) # Only for rewrite
      destination   = string
      preserve      = optional(bool)   # Only for rewrite
      redirect_type = optional(string) # Only for redirect
    }))
  }))
}


variable "origin_groups" {
  description = "Map of origin group configurations"
  type = map(object({
    name = string
    load_balancing = object({
      sample_size                 = number
      successful_samples_required = number
    })
    health_probe = object({
      path                = string
      request_type        = string
      protocol            = string
      interval_in_seconds = number
    })
    origins = map(object({
      host_name                      = string
      origin_host_header             = optional(string, null)
      http_port                      = number
      https_port                     = number
      priority                       = number
      weight                         = number
      enabled                        = bool
      certificate_name_check_enabled = bool
      private_link_service = optional(object({
        private_link_location        = string
        private_link_target_id       = string
        private_link_request_message = string
        private_link_target_type     = string
      }), null)
    }))
  }))
}

 