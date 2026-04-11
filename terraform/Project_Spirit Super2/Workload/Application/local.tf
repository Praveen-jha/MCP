locals {

  baseName1 = "${var.nameConfig.identity}${var.nameConfig.index}${var.nameConfig.deploymentEnvironment}"
  baseName2 = "${var.nameConfig.identity2}${var.nameConfig.index}-${substr(var.nameConfig.defaultLocation, 0, 2)}${substr(var.nameConfig.defaultLocation, 10, 1)}"
  
  networkRulesNull = {
    defaultAction = "Allow"
    bypass        = []
    ipRules       = []
  }

  TargetSubresource = {
    synapseSQLPeSubresourceNames               = ["Sql"]
    SynapseSQLOnDemandPeSubresourceNames       = ["SqlOnDemand"]
    synapseDevPeSubresourceNames               = ["Dev"]
    keyVaultPeSubresourceNames                 = ["vault"]
    adlsGen2BlobPeSubresourceNames             = ["blob"]
    adlsGen2DfsPeSubresourceNames              = ["dfs"]
    dbUiApiPeSubresourceNames                  = ["databricks_ui_api"]
    dbbrowsAuthPeSubresourceNames              = ["browser_authentication"]
  }
}