resource "google_compute_backend_service" "default" {
  name                    = "${var.name}-backend-service-${var.orchestration}"

  project = var.project_id

  protocol                = "HTTP"
  load_balancing_scheme   = "EXTERNAL_MANAGED"
  timeout_sec             = 10
  enable_cdn              = false
  health_checks           = [var.health_check_id]
  backend {
    group           = var.img_instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}


resource "google_compute_global_address" "default" {
  provider = google
  name     = "${var.name}-static-lb-ip-${var.orchestration}"
  project = var.project_id
}


resource "google_compute_global_forwarding_rule" "default" {
  project = var.project_id
  name                  = "${var.name}-forwarding-rule-${var.orchestration}"
  provider              = google
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

# http proxy
resource "google_compute_target_http_proxy" "default" {
  name     = "${var.name}-target-http-proxy-${var.orchestration}"

  project = var.project_id

  provider = google
  url_map  = google_compute_url_map.default.id
}

# url map
resource "google_compute_url_map" "default" {
  name            = "${var.name}-url-map-${var.orchestration}"
  project = var.project_id
  provider        = google
  default_service = google_compute_backend_service.default.id
}