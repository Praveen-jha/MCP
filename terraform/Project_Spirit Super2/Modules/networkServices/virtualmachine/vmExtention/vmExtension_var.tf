variable "vmExtensionName" {
  type = string
  description = "The name which should be used for this Synapse Self-hosted Integration Runtime."
}

variable "virtualMachineId" {
  type = string
  description = "Virtual Machien Resource ID."
}

variable "storageAccountName" {
  type = string
  description = "Name of the Storage Account"
}

variable "containerName" {
  type = string
  description = "Name of the container created inside storage account."
}

variable "blobName" {
  type = string
  description = "Name of the blob created inside container."
}

variable "shirKey" {
  type = string
  description = "Value of the Self Hosted Integration Runtime Key."
}

variable "accessKey" {
  type = string
  description = "Value of the Access Storage of Storage Account."
}