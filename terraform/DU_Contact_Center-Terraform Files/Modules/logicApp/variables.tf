#Variable to define logic app name
variable "logic_app_name" {
  type = string
  description = "Name of the logic app name"
}

#Variable to define logic app resource group name
variable "logic_app_resource_group_name" {
  type = string
  description = "Resource group of logic app"
}

#Variable to define logic app location
variable "logic_app_location" {
  type = string
  description = "Location of logic app"
}

#Variable to define logic app tags
variable "logic_app_tags" {
  type = map(string)
  description = "Tags value for logic app"
}