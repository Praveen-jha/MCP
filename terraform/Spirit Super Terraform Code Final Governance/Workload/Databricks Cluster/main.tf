# module "All_Purpose_Cluster" {
#   source                  = "../../Modules/Databricks Cluster"
#   depends_on              = [data.azurerm_databricks_workspace.databricks]
#   cluster_name            = var.cluster.name
#   node_type_id            = var.cluster.node
#   spark_version           = var.cluster.spark_version
#   min_workers             = var.cluster.min_workers
#   max_workers             = var.cluster.max_workers
#   data_security_mode      = var.cluster.security_mode
#   autotermination_minutes = var.cluster.autotermination_minutes
# }

module "SQL_Compute" {
  source                    = "../../Modules/databricksSQLCompute"
  depends_on                = [data.azurerm_databricks_workspace.databricks]
  sql_endpoint_name         = var.sql_compute.name
  cluster_size              = var.sql_compute.cluster_size
  min_clusters              = var.sql_compute.min_clusters
  max_clusters              = var.sql_compute.max_clusters
  auto_stop_mins            = var.sql_compute.auto_stop_mins
  enable_serverless_compute = var.sql_compute.enable_serverless_compute
  warehouse_type            = var.sql_compute.type 
}
