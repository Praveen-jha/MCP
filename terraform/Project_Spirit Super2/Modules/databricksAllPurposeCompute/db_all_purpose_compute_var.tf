variable "cluster_name" {
  type        = string
  description = "The name assigned to the Databricks cluster. This name is used to identify and manage the cluster within the Databricks environment."
}

variable "spark_version" {
  type        = string
  description = "The version of Apache Spark that the cluster will use. For example, '12.2.x-scala2.12' specifies a particular Spark runtime version compatible with Scala 2.12."
}

variable "node_type_id" {
  type        = string
  description = "The type of virtual machine (VM) to use for the cluster nodes. This determines the compute and memory resources available to the cluster (e.g., 'Standard_D4_v3')."
}

variable "min_workers" {
  type        = string
  description = "The minimum number of worker nodes to allocate for the cluster. This ensures that at least this number of nodes are always available to handle workload."
}

variable "max_workers" {
  type        = string
  description = "The maximum number of worker nodes that the cluster can scale up to. This allows the cluster to expand to handle larger workloads as needed."
}

variable "data_security_mode" {
  type        = string
  description = "The security mode for the cluster, such as 'Standard' or 'Premium'. This setting affects the security features and configurations available for the cluster."
}

variable "autotermination_minutes" {
  type        = string
  description = "The number of minutes of inactivity before the cluster automatically terminates. This helps manage costs by shutting down the cluster when it is not in use."
}
