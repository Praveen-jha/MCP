variable "storageAccountID" {
  type = string
  description = " Specifies the ID of the storage account. Changing this forces a new resource to be created."
}

variable "defaultAction" {
  type = string
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow."
}