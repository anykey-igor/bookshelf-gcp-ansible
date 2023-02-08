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
variable "health_check_id" {}
variable "img_instance_group" {}
