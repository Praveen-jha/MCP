variable "blobName" {
  type = string
  description = "Blob Service Name."
}

variable "storageAccountName" {
  type = string
  description = "Name of the storage Account."
}

variable "containerName" {
  type = string
  description = "Name of the contianer in which blob service is to be created."
}

variable "blobType" {
  type = string
  description = " The type of the storage blob to be created. Possible values are Append, Block or Page"
}

variable "blobAccessTier" {
  type = string
  description = "The access tier of the storage blob. Possible values are Archive, Cool and Hot."
}

variable "blobSource" {
  type = string
  description = "An absolute path to a file on the local system."
}
