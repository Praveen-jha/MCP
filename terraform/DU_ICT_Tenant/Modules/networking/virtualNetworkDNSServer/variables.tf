# List of custom DNS IP addresses to be used for firewall configuration.
variable "custom_dns_ip" {
  type        = list(string)
  description = "Custom DNS value."
}

variable "virtual_network_id" {
  type = string
  default = "Virtual network ID for DNS Server"
}