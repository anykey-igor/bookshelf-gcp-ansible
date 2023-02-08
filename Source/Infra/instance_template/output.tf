output "igm_instance_group" {
  value = google_compute_region_instance_group_manager.instance_group_manager.instance_group
}
output "igm_name" {
  value = google_compute_region_instance_group_manager.instance_group_manager.name
}
output "igm_id" {
  value = google_compute_region_instance_group_manager.instance_group_manager.id
}
output "igm_self_link" {
  value = google_compute_region_instance_group_manager.instance_group_manager.self_link
}
output "health_check_name" {
  value = google_compute_health_check.bookshelf_healthcheck.name
}
output "health_check_id" {
  value = google_compute_health_check.bookshelf_healthcheck.id
}
output "health_check_self_link" {
  value = google_compute_health_check.bookshelf_healthcheck.self_link
}
