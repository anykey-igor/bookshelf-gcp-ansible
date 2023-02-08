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
  description = "Optional) The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork."
  type        = string
  default     = "default"
}
variable "subnetwork" {
  description = "(Optional) The name or self_link of the subnetwork to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork. The subnetwork must exist in the same region this instance will be created in. If the network resource is in legacy mode, do not specify this field. If the network is in auto subnet mode, specifying the subnetwork is optional. If the network is in custom subnet mode, specifying the subnetwork is required."
  default     = ""
}
variable "subnetwork_name" {
  description = "(Optional) The name or self_link of the subnetwork to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork. The subnetwork must exist in the same region this instance will be created in. If the network resource is in legacy mode, do not specify this field. If the network is in auto subnet mode, specifying the subnetwork is optional. If the network is in custom subnet mode, specifying the subnetwork is required."
  default     = ""
}
variable "subnetwork_project" {
  description = "(Optional) The project in which the subnetwork belongs. If the subnetwork is a self_link, this field is ignored in favor of the project defined in the subnetwork self_link. If the subnetwork is a name and this field is not provided, the provider project is used."
  default     = ""
}
variable "subnet_region" {}
variable "subnetwork_id" {}
variable "mysql_url" {}
variable "mysql_db" {}
variable "user_pass" {}
variable "bucket_url" {}
variable "startup_script" {}
variable "purpose" {
  type        = string
  description = "The purpose of the resource(GCE_ENDPOINT, SHARED_LOADBALANCER_VIP, VPC_PEERING)."
  default     = "GCE_ENDPOINT"
}
variable "ip_address" {
  description = "The private IP address to assign to the instance. If empty, the address will be automatically assigned."
  default     = ""
}
variable "nat_ip" {
  description = "(Optional) The IP address that will be 1:1 mapped to the instance's network ip. If not given, one will be generated."
  type        = string
  default     = ""
}
variable "network_tier" {
  description = "(Optional) The networking tier used for configuring this instance. This field can take the following values: PREMIUM, FIXED_STANDARD or STANDARD. If this field is not specified, it is assumed to be PREMIUM."
  type        = string
  default     = "STANDARD"
}
variable "public_ptr_domain_name" {
  description = "(Optional) The DNS domain name for the public PTR record. To set this field on an instance, you must be verified as the owner of the domain. See the docs for how to become verified as a domain owner."
  type        = string
  default     = ""
}
variable "network_tags" {
  type    = list(string)
  default = []
}
variable "machine_type" {
  type    = string
  default = "g1-small"
}

#---------------------------------------------------------------------------------------------------------------------
# Service Account Parameter
#---------------------------------------------------------------------------------------------------------------------
variable "email_sa" {
  description = "(Optional) The service account e-mail address. If not given, the default Google Compute Engine service account is used. Note: allow_stopping_for_update must be set to true or your instance must have a desired_status of TERMINATED in order to update this field."
  type        = string
  default     = ""
}
variable "service_account_scope" {
  type    = list(any)
  default = []
}
variable "timeout_create" {
  type    = string
  default = "5m"
}
variable "timeout_update" {
  type    = string
  default = "4m"
}
variable "timeout_delete" {
  type    = string
  default = "5m"
}
#---------------------------------------------------------------------------------------------------------------------
# General Variables for Google Compute Address
#---------------------------------------------------------------------------------------------------------------------
variable "enable_compute_address" {
  type    = bool
  default = false
}
variable "name_ca" {
  type    = string
  default = "test"
}
variable "prefix_ip" {
  type    = string
  default = "private"
}
variable "description_ca" {
  type    = string
  default = "test_ip"
}
variable "address_type" {
  description = "(Optional) The type of address to reserve. Default value is EXTERNAL. Possible values are INTERNAL and EXTERNAL"
  type        = string
  default     = "INTERNAL"
}

