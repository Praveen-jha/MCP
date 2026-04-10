locals {

  # private_dns_zone_ids_same_vnet = var.dns_zone_creation == "new" && var.private_endpoint_same_vnet == true ? [module.Private_Dns_Zone_same_vnet[0].private_dns_zone_id] : [var.pdz_id_same_vnet]
  # private_dns_zone_ids_diff_vnet = var.dns_zone_creation == "new" && var.private_endpoint_diff_vnet == true ? [module.Private_Dns_Zone_diff_vnet[0].private_dns_zone_id] : [var.pdz_id_diff_vnet]

}
