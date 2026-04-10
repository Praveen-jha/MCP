variable "containerName" {
  type = string
  description = "The name of the Container which should be created within the Storage Account."
}

variable "storageAccountName" {
  type = string
  description = "The name of the Storage Account where the Container should be created."
}

variable "containerAccessType" {
  type = string
  description = "The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private."
}
