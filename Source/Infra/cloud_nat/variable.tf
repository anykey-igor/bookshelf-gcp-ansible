#---------------------------------------------------------------------------------------------------------------------
# General Variables
#---------------------------------------------------------------------------------------------------------------------
variable "project_id" {
  type    = string
  default = ""
}
variable "region" {
  type    = string
  default = "europe-west1"
}
variable "zone" {
  type    = string
  default = "europe-west1-b"
}
variable "environment" {
  type    = string
  default = "DEMO"
}
variable "orchestration" {
  type    = string
  default = "tf"
}
variable "name" {
  type    = string
  default = "bookshelf"
}

variable "network" {
  description = "(Optional) The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork."
  type    = string
  default = ""
}
variable "enable_nat" {
  type = bool
  default = false
}
variable "subnet_region" {}
variable "subnetwork_id" {}