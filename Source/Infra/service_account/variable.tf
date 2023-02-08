#---------------------------------------------------------------------------------------------------------------------
# General Variables
#---------------------------------------------------------------------------------------------------------------------
variable "project_id" {
  description = "Project ID"
  type        = string
  default     = "gcp-2022-bookshelf-ianikeiev1"
}
variable "names" {
  type        = list(string)
  description = "Names of the service accounts to create."
  default     = []
}
variable "descriptions" {
  type        = list(string)
  description = "List of descriptions for the created service accounts (elements default to the value of `description`)"
  default     = []
}
variable "sa_roles" {
  description = "Declare SA and roles"
  #type        = list(map(any))
  #default     = [{
  #    sa_name     = ""
  #    sa_description = ""
  #    sa_roles     = []
  #}]
}
variable "gr_roles" {
  description = "Declare SA and roles"
  #type        = list(map(any))
  #default     = [{
  #    sa_name     = ""
  #    sa_description = ""
  #    sa_roles     = []
  #}]
}