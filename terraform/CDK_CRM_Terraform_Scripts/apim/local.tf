#local.tf

locals {
  product_api_links = flatten([
    for pk, p in var.products : [
      for api_key in p.apis : {
        product_key = pk
        api_key     = api_key
      }
    ]
  ])
}

locals {
  product_group_links = flatten([
    for pk, groups in var.product_groups : [
      for gk in groups : {
        product_key = pk
        group_key   = gk
      }
    ]
  ])
}

locals {
  group_user_links = flatten([
    for uk, u in var.users : [
      for gk in u.groups : {
        user_key  = uk
        group_key = gk
      }
    ]
  ])
}