output "id" {
  value       = databricks_sql_endpoint.this.id
  description = "the unique ID of the SQL warehouse."
}

output "data_source_id" {
  value       = databricks_sql_endpoint.this.data_source_id
  description = "ID of the data source for this endpoint. This is used to bind an Databricks SQL query to an endpoint."
}