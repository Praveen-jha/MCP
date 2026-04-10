resource "databricks_sql_endpoint" "this" {
  name                      = var.sql_endpoint_name
  cluster_size              = var.cluster_size
  min_num_clusters          = var.min_clusters
  max_num_clusters          = var.max_clusters
  warehouse_type            = var.warehouse_type
  auto_stop_mins            = var.auto_stop_mins
  enable_serverless_compute = var.enable_serverless_compute
}

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.49.1"
    }
  }
}
