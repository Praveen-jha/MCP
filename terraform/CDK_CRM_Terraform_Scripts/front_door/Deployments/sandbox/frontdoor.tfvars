region = "Central US"
name_config = {
  identity       = "afd"
  businessunit   = "app"
  environment    = "nebula"
  locationflag   = "cus"
  resource_group = "01"
}
existing_frontdoor        = false
cdn_fd_name               = "afd-app-nebula-sdb-cus-01"
resource_group_name       = "rg-afd-nebula-sdb-cus-01"
endpoint_name             = ["endpoint1", "endpoint2"]
front_door_sku_name       = "Premium_AzureFrontDoor"
use_existing_origin_group = false
use_existing_rulesets     = false
use_existing_waf_policy   = false
use_existing_certificate  = true
use_existing_secret       = false

origin_groups = {
  agw-origin-group = {
    name = "agworigin"
    load_balancing = {
      sample_size                 = 4
      successful_samples_required = 3
    }
    health_probe = {
      path                = "/"
      request_type        = "HEAD"
      protocol            = "Https"
      interval_in_seconds = 100
    }
    origins = {
      origin-1 = {
        host_name = "xxx"
        # origin_host_header             = "www.cdkdemo.networksoln.tech"
        http_port                      = 80
        https_port                     = 443
        priority                       = 1
        weight                         = 1000
        enabled                        = true
        certificate_name_check_enabled = false
        //additional private link configuration
      }
    }
  }
}

routes = {
  route1 = {
    route_name          = "homeroute"
    endpoint_name       = "endpoint1"
    origin_group_name   = "agworigin"
    origin_names        = ["origin-1"]
    custom_domain_names = ["cdkdemo"]
    ruleset_names       = ["rewriteruleset"]
  }
}

custom_domains = {
  cdkdemo = {
    host_name           = "cdkdemo.networksoln.tech"
    cert_name           = "Certificate02"
    certificate_version = "v1"
    key_vault_name      = "kv-m-bi-tst-cus-01bf"
    resource_group      = "rg-app-nebula-sdb-cus-01"
    association         = ["route1"]
  }
}

waf_policies = {}

rule_sets = {
  rewriteruleset = {
    name = "rewriteruleset"
    rules = {
      rewriterule1 = {
        order       = 1
        type        = "rewrite"
        source      = "/old-path"
        destination = "/new-path"
        preserve    = false
      }
    }
  }
}
