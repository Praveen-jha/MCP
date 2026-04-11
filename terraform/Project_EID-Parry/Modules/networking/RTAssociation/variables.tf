variable "rt_id" {
  type        = string
  description = "route table id to associate subnet with."
}

variable "subnet_id" {
  type        = string
  description = "subnet id to associate route table with."
}
