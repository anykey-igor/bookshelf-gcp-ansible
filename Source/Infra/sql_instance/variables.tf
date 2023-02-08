#---------------------------------------------------------------------------------------------------------------------
# General Variables
#---------------------------------------------------------------------------------------------------------------------
variable "project" {
  type    = string
  default = "gcp-2022-1-phase2-anikeiev"
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
  default = "petclinic"
}

#---------------------------------------------------------------------------------------------------------------------
# General Variables for SQL Instance
#---------------------------------------------------------------------------------------------------------------------
variable "enable_sql_instance" {
  type    = bool
  default = false
}
variable "sql_instance_name" {
  type    = string
  default = "database_name"
}
variable "db_prefix" {
  type    = string
  default = "db"
}
variable "description_sql" {
  type    = string
  default = "Info about this VPC"
}
variable "db_version" {
  type    = string
  default = "MYSQL_5_7"
}
variable "address_subnet" {
  type    = string
  default = ""
}
variable "ip_version" {
  type    = string
  default = "IPV4"
}
variable "subnet_prefix" {
  type    = string
  default = "24"
}


#---------------------------------------------------------------------------------------------------------------------
# General Variables for SQL Database
#---------------------------------------------------------------------------------------------------------------------
variable "enable_default_db" {
  description = "Enable or disable the creation of the default database"
  type        = bool
  default     = true
}
variable "db_name" {
  description = "The name of the default database to create"
  type        = string
  default     = "default"
}
variable "db_charset" {
  description = "The charset for the default database"
  type        = string
  default     = ""
}
variable "db_collation" {
  description = "The collation for the default database. Example: 'utf8_general_ci'"
  type        = string
  default     = ""
}

#---------------------------------------------------------------------------------------------------------------------
# General Variables for SQL User
#---------------------------------------------------------------------------------------------------------------------
variable "enable_default_user" {
  description = "Enable or disable the creation of the default user"
  type        = bool
  default     = true
}
variable "user_name" {
  description = "The name of the default user"
  type        = string
  default     = "default"
}
variable "user_host" {
  description = "The host for the default user"
  type        = string
  default     = "%"
}
variable "user_password" {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  type        = string
  default     = ""
}
variable "additional_users" {
  description = "A list of users to be created in your cluster"
  type        = list(map(any))
  default = [{
    name     = "testUser"
    password = "TESTpassWord"
    host     = "localhost"
    type     = "BUILT_IN"
  }]
}

variable "network" {
  description = "Optional) The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork."
}
variable "network_id" {
  description = "Optional) The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork."
}
variable "network_self_link" {
  description = "(Optional) The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork."
}
variable "subnetwork" {
  description = "(Optional) The name or self_link of the subnetwork to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork. The subnetwork must exist in the same region this instance will be created in. If the network resource is in legacy mode, do not specify this field. If the network is in auto subnet mode, specifying the subnetwork is optional. If the network is in custom subnet mode, specifying the subnetwork is required."
  default     = ""
}
variable "subnetwork_self_link" {
  description = ""
  default     = ""
}