resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = var.cluster_name
  node_type_id            = var.node_type_id
  spark_version           = var.spark_version
  autotermination_minutes = var.autotermination_minutes
  data_security_mode      = var.data_security_mode 

  autoscale {
    min_workers = var.min_workers
    max_workers = var.max_workers
  }

}

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.49.1"
    }
  }
}
