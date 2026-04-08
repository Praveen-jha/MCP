common_tags = {
  "ApplicationName" = "databricks"
  "ProjectName"     = "databricks"
  "Environment"     = "nrpod"
  "CreationDate"    = "19-08-2025"
  "CreatedBy"       = "ITSystems"
  "BusinessOwner"   = "analytics team"
  "ApplicationTier" = "T2"
  "Department"      = "IMT"
}
networking = {
  spoke_rg_name        = "rg-dpw-nprod-qc-01"
  spoke_vnet_name      = "vnet-dbw-nprod-qc-01"
  dbx_host_subnet      = "snet-dpw-host-nprod-qc-01"
  dbx_container_subnet = "snet-dpw-container-nprod-qc-01"
  spoke_pep_subnet     = "snet-dpw-pe-nprod-qc-01"
  spoke_compute_subnet = "snet-dpw-compute-nprod-qc-01"
}
self_hosted_integration_runtime_vm = {
  vm_name           = "qcawshd01npdvn1"
  vm_size           = "Standard_D2s_v5"
  availability_zone = "1"
  admin_username    = "localadmin"
}
self_hosted_integration_runtime_vm_2 = {
  vm_name           = "qcawshd01npdvn2"
  vm_size           = "Standard_D2s_v5"
  availability_zone = "2"
  admin_username    = "localadmin"
}
on_premises_data_gateway_vm = {
  vm_name           = "qcawpgw01npdvn1"
  vm_size           = "Standard_D2s_v5"
  availability_zone = "1"
  admin_username    = "localadmin"
}
on_premises_data_gateway_vm_2 = {
  vm_name           = "qcawpgw01npdvn2"
  vm_size           = "Standard_D2s_v5"
  availability_zone = "2"
  admin_username    = "localadmin"
}

source_image_id = ""
