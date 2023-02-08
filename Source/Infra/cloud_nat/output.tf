output "router" {
  description = "Router Name"
  value = google_compute_router.router.*.name
}
output "router_id" {
  description = "Router Name"
  value = google_compute_router.router.*.id
}
output "router_sellink" {
  description = "Router Name"
  value = google_compute_router.router.*.self_link
}
output "router_network" {
  description = "Router Name"
  value = google_compute_router.router.*.network
}