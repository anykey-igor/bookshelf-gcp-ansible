##---------------------------------------------------------------------------------------------------------------------
## Network
##---------------------------------------------------------------------------------------------------------------------
#output "google_compute_network_name" {
#  description = "Name of google compute network"
#  value       = module.vpc.google_compute_network_name
#}
#output "google_compute_network_id" {
#  description = "Name of google compute network"
#  value       = module.vpc.google_compute_network_id
#}
#output "google_compute_network_self_link" {
#  description = "The URI of the created resource."
#  value       = module.vpc.google_compute_network_self_link
#}
#output "google_compute_network_gateway_ipv4" {
#  description = "The IPv4 address of the gateway."
#  value       = module.vpc.google_compute_network_gateway_ipv4
#}
##---------------------------------------------------------------------------------------------------------------------
## Subnetwork
##---------------------------------------------------------------------------------------------------------------------
#output "google_compute_subnetwork_name" {
#  description = "Subnetwork Name"
#  value       = module.vpc.google_compute_subnetwork_name
#}
#output "google_compute_subnetwork_self_link" {
#  description = "The URI of the created resource."
#  value       = module.vpc.google_compute_subnetwork_self_link
#}
#output "google_compute_subnetwork_gateway_address" {
#  description = "The gateway address for default routes to reach destination addresses outside this subnetwork."
#  value       = module.vpc.google_compute_subnetwork_gateway_address
#}
#output "subnet_region" {
#  value = module.vpc.subnet_region
#}
#output "subnetworks_id" {
#  value = module.vpc.google_compute_subnetwork_id
#}
#
##---------------------------------------------------------------------------------------------------------------------
## Firewall
##---------------------------------------------------------------------------------------------------------------------
#output "all_ingress_firewall_name" {
#  description = "Name of google compute firewall"
#  value       = module.vpc.all_ingress_firewall_name
#}
#output "all_ingress_firewall_self_link" {
#  description = "Self link"
#  value       = module.vpc.all_ingress_firewall_self_link
#}
#output "custom_ingress_firewall_name" {
#  description = "Name of google compute firewall"
#  value       = module.vpc.custom_ingress_firewall_name
#}
#output "custom_ingress_firewall_tags" {
#  description = "Name of google compute firewall tags"
#  value = module.vpc.custom_ingress_firewall_tags
#}
#output "custom_ingress_firewall_self_link" {
#  description = "Self link"
#  value       = module.vpc.custom_ingress_firewall_self_link
#}
#
##---------------------------------------------------------------------------------------------------------------------
## SQL
##---------------------------------------------------------------------------------------------------------------------
#output "instance_name" {
#  description = "The instance name for the master instance"
#  value       = module.sql_instance.instance_name
#}
#output "instance_ip_address" {
#  value       = module.sql_instance.instance_ip_address
#  description = "The IPv4 address assigned for the master instance"
#}
#output "private_address" {
#  value       = module.sql_instance.private_address
#  description = "The private IP address assigned for the master instance"
#}
#output "instance_first_ip_address" {
#  value       = module.sql_instance.instance_first_ip_address
#  description = "The first IPv4 address of the addresses assigned for the master instance."
#}
#output "instance_connection_name" {
#  value       = module.sql_instance.instance_connection_name
#  description = "The connection name of the master instance to be used in connection strings"
#}
#output "instance_self_link" {
#  value       = module.sql_instance.instance_self_link
#  description = "The URI of the master instance"
#}
##output "instance_server_ca_cert" {
##  value       = module.sql_instance.instance_server_ca_cert
##  description = "The CA certificate information used to connect to the SQL instance via SSL"
##  sensitive = true
##}
#output "instance_service_account_email_address" {
#  value       = module.sql_instance.instance_service_account_email_address
#  description = "The service account email address assigned to the master instance"
#}
#output "additional_users" {
#  description = "List of maps of additional users and passwords"
#  value = module.sql_instance.additional_users
#  sensitive = true
#}
#output "db_name" {
#  value = module.sql_instance.db_name
#  sensitive = true
#}
##---------------------------------------------------------------------------------------------------------------------
## Storage Bucket
##---------------------------------------------------------------------------------------------------------------------
#output "google_storage_bucket_name" {
#  description = "Name of google storage bucket"
#  value = module.bookshelf_bucket.google_storage_bucket_name
#}
#output "google_storage_bucket_self_link" {
#  description = "self_link of google storage bucket"
#  value = module.bookshelf_bucket.google_storage_bucket_self_link
#}
#output "google_storage_bucket_url" {
#  description = "URL of google storage bucket"
#  value = module.bookshelf_bucket.google_storage_bucket_url
#}
##---------------------------------------------------------------------------------------------------------------------
## Service Account
##---------------------------------------------------------------------------------------------------------------------
#output "service_account_name" {
#  value = module.bookshelf_sa.service_account_name
#}
#output "service_account_display_name" {
#  value = module.bookshelf_sa.service_account_display_name
#}
#output "service_account_id" {
#  value = module.bookshelf_sa.service_account_id
#}
#output "service_account_email" {
#  value = module.bookshelf_sa.service_account_email
#}
#
##---------------------------------------------------------------------------------------------------------------------
## Instance Template - Manage Instance Group - Health Check
##---------------------------------------------------------------------------------------------------------------------
#output "igm_instance_group" {
#  value = module.instance_template.igm_instance_group
#}
#output "igm_name" {
#  value = module.instance_template.igm_name
#}
#output "igm_id" {
#  value = module.instance_template.igm_id
#}
#output "igm_self_link" {
#  value = module.instance_template.igm_self_link
#}
#output "health_check_name" {
#  value = module.instance_template.health_check_name
#}
#output "health_check_id" {
#  value = module.instance_template.health_check_id
#}
#output "health_check_self_link" {
#  value = module.instance_template.health_check_self_link
#}
output "bookshelf_URL" {
  value = "http://${module.bookshelf-lb.external_ip_lb}"
}