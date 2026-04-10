nameConfig = {
    defaultLocation                       = "australia east"
    existingdataGovernanceRGName          = "ngdp1t-governance-rg"
    existingNetworkRGName                 = "ngdp1t-networking-rg"
    existingVnetName                      = "platform1-aue-vnet1"
    deploymentEnvironment                 = "test"
    identity                              = "ngdp"
    identity2                             = "platform"
    index                                 = 1
    publicNetworkAccessEnabled            = false
    tags                           = {
        business_owner        = "Technology"
        managed_by            = "terraform"
        source                = ""
    }
}

cluster = {
  name                    = "All Purpose Compute"
  node                    = "Standard_D4a_v4"
  spark_version           = "14.3.x-scala2.12"
  security_mode           = "USER_ISOLATION"
  min_workers             = 1
  max_workers             = 5
  autotermination_minutes = 10
}

sql_compute = {
  name                      = "SQL-Compute"
  cluster_size              = "2X-Small"
  enable_serverless_compute = "false"
  type                      = "CLASSIC"
  min_clusters              = 1
  max_clusters              = 3
  auto_stop_mins            = 10
}