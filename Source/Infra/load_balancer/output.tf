output "external_ip_lb" {
  value = google_compute_global_address.default.address
}