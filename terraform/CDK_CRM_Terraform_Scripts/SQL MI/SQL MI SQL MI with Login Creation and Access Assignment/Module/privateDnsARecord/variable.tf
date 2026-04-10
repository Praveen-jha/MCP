variable "private_dns_zone_resource_group_name" {
  description = "Name of the resource group containing the Private DNS zone"
  type        = string
}

variable "private_dns_record_name" {
  type = string
  description = "name of the record"
}

variable "records" {
  type = list(string)
  description = "value of the record"
}

variable "private_dns_zone_name" {
  type = string
  description = "name of the zone"
}
