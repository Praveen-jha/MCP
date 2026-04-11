locals {
  
  baseName1 = "${var.nameConfig.identity}${var.nameConfig.index}${var.nameConfig.deploymentEnvironment}"
  baseName2 = "${var.nameConfig.identity2}${var.nameConfig.index}-${substr(var.nameConfig.defaultLocation, 0, 2)}${substr(var.nameConfig.defaultLocation, 10, 1)}"
}