variable "sql_endpoint_name" {
  type        = string
  description = "(Required) Name of the SQL warehouse. Must be unique."
}

variable "cluster_size" {
  type        = string
  description = " (Required) The size of the clusters allocated to the endpoint: 2X-Small, X-Small, Small, Medium, Large, X-Large, 2X-Large 3X-Large, 4X-Large "
}

variable "min_clusters" {
  type        = string
  description = "Minimum number of clusters available when a SQL warehouse is running. The default is"
}

variable "max_clusters" {
  type        = string
  description = "Maximum number of clusters available when a SQL warehouse is running. This field is required. If multi-cluster load balancing is not enabled, this is default to"
}

variable "auto_stop_mins" {
  type        = string
  description = "Time in minutes until an idle SQL warehouse terminates all clusters and stops. This field is optional. The default is 120, set to 0 to disable the auto stop."
}

variable "enable_serverless_compute" {
  type        = string
  description = "Whether this SQL warehouse is a serverless endpoint, To avoid ambiguity, especially for organizations with many workspaces, Databricks recommends that you always set this field explicitly."
}

variable "warehouse_type" {
  type        = string
  description = "SQL warehouse type, PRO or CLASSIC the default is PRO, which is required for serverless SQL warehouses. Otherwise, the default is CLASSIC."
}

