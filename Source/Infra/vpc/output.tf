#---------------------------------------------------------------------------------------------------------------------
# Network
#---------------------------------------------------------------------------------------------------------------------
output "google_compute_network_name" {
  description = "Name of google compute network"
  value       = google_compute_network.vpc_network.*.name
}
output "google_compute_network_id" {
  description = "Name of google compute network"
  value       = google_compute_network.vpc_network.*.id
}
output "google_compute_network_self_link" {
  description = "The URI of the created resource."
  value       = google_compute_network.vpc_network.*.self_link
}
output "google_compute_network_gateway_ipv4" {
  description = "The IPv4 address of the gateway."
  value       = google_compute_network.vpc_network.*.gateway_ipv4
}

#---------------------------------------------------------------------------------------------------------------------
# Subnetwork
#---------------------------------------------------------------------------------------------------------------------
output "google_compute_subnetwork_name" {
  description = "Name"
  value       = google_compute_subnetwork.compute_subnetwork.*.name
}
output "google_compute_subnetwork_id" {
  description = "Subnetwork ID"
  value       = google_compute_subnetwork.compute_subnetwork.*.id
}
output "google_compute_subnetwork_self_link" {
  description = "The URI of the created resource."
  value       = google_compute_subnetwork.compute_subnetwork.*.self_link
}
output "google_compute_subnetwork_gateway_address" {
  description = "The gateway address for default routes to reach destination addresses outside this subnetwork."
  value       = google_compute_subnetwork.compute_subnetwork.*.gateway_address
}
output "subnet_region" {
  description = "Subnetwork Region"
  value = google_compute_subnetwork.compute_subnetwork.*.region
}

#---------------------------------------------------------------------------------------------------------------------
# Firewall
#---------------------------------------------------------------------------------------------------------------------
output "all_ingress_firewall_name" {
  description = "Name of google compute firewall"
  value       = google_compute_firewall.compute_firewall_all_ingress.*.name
}
output "all_ingress_firewall_self_link" {
  description = "Self link"
  value       = google_compute_firewall.compute_firewall_all_ingress.*.self_link
}
output "custom_ingress_firewall_name" {
  description = "Name of google compute firewall"
  value       = google_compute_firewall.custom_firewall_ingress_rules.*.name
}
output "custom_ingress_firewall_tags" {
  description = "Name of google compute firewall tags"
  value = google_compute_firewall.custom_firewall_ingress_rules.*.target_tags
}
output "custom_ingress_firewall_self_link" {
  description = "Self link"
  value       = google_compute_firewall.custom_firewall_ingress_rules.*.self_link
}