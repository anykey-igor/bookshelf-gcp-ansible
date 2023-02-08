#---------------------------------------------------------------------------------------------------------------------
# General Variables
#---------------------------------------------------------------------------------------------------------------------
variable "project" {
  type    = string
  default = ""
}
variable "region" {
  type    = string
  default = ""
}
variable "zone" {
  type    = string
  default = ""
}
variable "environment" {
  type    = string
  default = "DEMO"
}
variable "orchestration" {
  type    = string
  default = ""
}
variable "name" {
  type    = string
  default = ""
}

#---------------------------------------------------------------------------------------------------------------------
# General Variables for VPC Network
#---------------------------------------------------------------------------------------------------------------------
variable "enable_vpc" {
  type    = bool
  default = false
}
variable "vpc_of_name" {
  type    = string
  default = "TEST"
}
variable "description_vpc" {
  type    = string
  default = "Info about this VPC"
}
variable "auto_create_subnetworks" {
  description = "Optional) When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  type        = bool
  default     = false
}
variable "routing_mode" {
  description = "(Optional) The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. Possible values are REGIONAL and GLOBAL"
  type        = string
  default     = "REGIONAL"
}
variable "mtu_size" {
  description = "(Optional) Maximum Transmission Unit in bytes. The minimum value for this field is 1460 and the maximum value is 1500 bytes."
  type        = number
  default     = 1460
}
variable "delete_default_routes_on_create" {
  description = "(Optional) If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation. Defaults to false."
  type        = bool
  default     = false
}

#---------------------------------------------------------------------------------------------------------------------
# General Variables for VPC Subnetwork
#---------------------------------------------------------------------------------------------------------------------
variable "enable_subnetwork" {
  type    = bool
  default = false
}
variable "description_subnetwork" {
  type    = string
  default = "Info about subnetwork"
}
variable "ip_cidr_range" {
  type    = string
  default = ""
}
variable "private_ip_google_access" {
  description = "(Optional) When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
  type        = bool
  default     = false
}


#---------------------------------------------------------------------------------------------------------------------
# General Variables for Firewall
#---------------------------------------------------------------------------------------------------------------------
variable "enable_all_ingress" {
  description = "Enable all ports for ingress traffic"
  default     = false
}
variable "enable_custom_ingress_rules" {
  type    = bool
  default = false
}
variable "description_firewall" {
  type    = string
  default = ""
}
variable "priority" {
  description = "The priority for this firewall. Ranges from 0-65535, inclusive. Defaults to 1000. Firewall resources with lower priority values have higher precedence (e.g. a firewall resource with a priority value of 0 takes effect over all other firewall rules with a non-zero priority)."
  default     = "1000"
}
variable "source_ranges" {
  description = "A list of source CIDR ranges that this firewall applies to. Can't be used for EGRESS."
  default     = []
}
variable "source_tags" {
  description = "A list of source tags for this firewall. Can't be used for EGRESS."
  default     = []
}
variable "target_tags" {
  description = "A list of target tags for this firewall."
  type        = list(any)
  default     = []
}
variable "direction" {
  description = "Direction of traffic to which this firewall applies; One of INGRESS or EGRESS. Defaults to INGRESS."
  default     = "INGRESS"
}
variable "ingres_rules" {
  type    = list(any)
  default = []
}
variable "rules" {
  type = map(list(any))
  default = {
    http-80   = [80, "tcp", "http", "web-80", "Allow 80 port from any"]
    http-8080 = [8080, "tcp", "http-8080", "web-8080", "Allow 8080 port from any"]
    ssh       = [22, "tcp", "ssh", "ssh", "Allow 22 port from any"]
  }
}