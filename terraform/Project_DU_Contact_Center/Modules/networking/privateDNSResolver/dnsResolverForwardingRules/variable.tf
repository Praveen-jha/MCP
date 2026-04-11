variable "name" {
  description = "Name of the DNS forwarding rule"
  type        = string
}

variable "dns_forwarding_ruleset_id" {
  description = "ID of the DNS forwarding ruleset"
  type        = string
}

variable "domain_name" {
  description = "Domain name to forward (must end with a dot)"
  type        = string
}

variable "enabled" {
  description = "Whether the rule is enabled"
  type        = bool
  default     = true
}

variable "target_dns_servers" {
  description = <<EOF
List of target DNS servers. Each item must be an object with 'ip_address' and 'port'.
Example:
[
  {
    ip_address = "10.10.0.1"
    port       = 53
  },
    {
    ip_address = "10.10.0.1"
    port       = 53
  },
    {
    ip_address = "10.10.0.1"
    port       = 53
  }
]
EOF
  type = list(object({
    ip_address = string
    port       = number
  }))
}

variable "metadata" {
  description = "Metadata for the forwarding rule"
  type        = map(string)
  default     = {}
}
