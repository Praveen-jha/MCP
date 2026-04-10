variable "scope" {
  description = "scope of the rbac assignment"
  type        = string
}
variable "role" {
  description = "role that needs to be assigned"
  type        = string
}
variable "principal_id" {
  description = "principal id that needs the assignment on the scope"
  type        = string
}