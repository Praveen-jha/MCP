variable "name" {
  description = "Name of the Private DNS Resolver Inbound Endpoint"
  type        = string
}

variable "private_dns_resolver_id" {
  description = "ID of the Private DNS Resolver"
  type        = string
}

variable "location" {
  description = "Azure region for the inbound endpoint"
  type        = string
}

variable "ip_configurations" {
  description = <<EOF
List of IP configuration objects. Each object must have:
- private_ip_allocation_method (string, e.g., 'Dynamic' or 'Static')
- subnet_id (string)
Example:
[
  {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = "subnet-id"
  }
]
EOF
  type = list(object({
    private_ip_allocation_method = string
    subnet_id                    = string
  }))
}

variable "tags" {
  description = "Tags for the inbound endpoint"
  type        = map(string)
  default     = {}
}
