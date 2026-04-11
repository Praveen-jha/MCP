variable "nameConfig" {
  type = object({
    defaultLocation              = string
    tags                         = map(string)
    existingdataGovernanceRGName = string
    existingNetworkRGName        = string
    existingVnetName             = string
    deploymentEnvironment        = string
    identity                     = string
    identity2                    = string
    index                        = number
    publicNetworkAccessEnabled   = bool
  })
  description = "Variable to Provide Values required for the Deployment, e.g., Location, Tags, Environment,etc."
}

variable "cluster" {
  type = object({
    name                    = string // Name of the compute cluster.
    node                    = string // Node type of the cluster (e.g., Standard_D4_v3).
    spark_version           = string // Version of Apache Spark to use (e.g., 12.2.x-scala2.12).
    security_mode           = string // Security mode for the cluster (e.g., Standard or Premium).
    min_workers             = number // Minimum number of worker nodes to allocate.
    max_workers             = number // Maximum number of worker nodes to allocate.
    autotermination_minutes = number // Number of minutes of inactivity before auto-termination.
  })
}

variable "sql_compute" {
  type = object({
    name                      = string // Name of the SQL warehouse. 
    cluster_size              = string // Size of the SQL warehouse cluster (e.g., Small, Medium, Large). This determines the compute resources allocated to the warehouse.
    enable_serverless_compute = string // Specifies whether serverless compute is enabled. Should be "true" or "false". Serverless compute provides automatic scaling and management.
    type                      = string // Type of the SQL warehouse. Options include "PRO" for professional and "CLASSIC" for classic SQL warehouses. This impacts feature availability and performance characteristics.
    min_clusters              = number // Minimum number of clusters for the SQL warehouse. Ensures that at least this number of clusters are available to handle queries.
    max_clusters              = number // Maximum number of clusters for the SQL warehouse. Allows the warehouse to scale up to this number of clusters based on demand.
    auto_stop_mins            = number // Number of minutes of inactivity before the SQL warehouse automatically stops. Helps in cost management by terminating idle resources.
  })
}