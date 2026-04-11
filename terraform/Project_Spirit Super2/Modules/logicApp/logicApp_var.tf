variable "logicAppName" {
  type = string
  description = "Name of the Logic App to be created."
}

variable "resourceGroupName" {
  type = string
  description = "The name of the Azure Resource Group where the Logic App will be created."
}

variable "location" {
  type = string
  description = "The location (region) where the Logic App will be created."
}

variable "tags" {
  description = "A map of tags to assign to the Azure Logic App."
  type        = map(string)

}