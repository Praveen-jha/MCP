variable "name_config" {
  description = "Name configuration for the resource"
  type = object({
    identity     = string
    businessunit = string
    environment  = string
    locationflag = string
  })
}

variable "region" {
  type        = string
  description = "Azure region"
}

variable "existing_frontdoor" {
  type        = bool
  description = "Configure existing Front Door?"
}

variable "cdn_fd_name" {
  type        = string
  description = "Front Door name"
}

variable "endpoint_name" {
  type        = list(string)
  description = "List of Front Door endpoint names"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "front_door_sku_name" {
  type        = string
  description = "Front Door SKU"
}

variable "use_existing_origin_group" {
  type        = bool
  description = "Use existing origin group?"
}

variable "use_existing_rulesets" {
  type        = bool
  description = "Use existing rule sets?"
}

variable "use_existing_waf_policy" {
  type        = bool
  description = "Use existing WAF policy?"
}

variable "use_existing_certificate" {
  type        = bool
  description = "Use existing Key Vault certificate?"
}

variable "use_existing_secret" {
  type        = bool
  description = "Use existing Key Vault secret?"
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

variable "routes" {
  description = "Map of route configurations"
  type = map(object({
    route_name          = string
    endpoint_name       = string
    origin_group_name   = string
    origin_names        = list(string)
    custom_domain_names = list(string)
    ruleset_names       = list(string)
  }))
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

variable "waf_policies" {
  description = "Map of WAF policy configurations"
  type = map(object({
    name        = string
    mode        = string
    domain_name = string
    patterns    = list(string)
  }))
  default = {}
}

variable "rule_sets" {
  description = "Map of rule sets with rules"
  type = map(object({
    name = string
    rules = map(object({
      order         = number
      type          = string
      source        = optional(string)
      destination   = string
      preserve      = optional(bool)
      redirect_type = optional(string)
    }))
  }))
}
