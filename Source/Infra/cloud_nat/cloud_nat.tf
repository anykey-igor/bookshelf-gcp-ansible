resource "google_compute_router" "router" {
  count = var.enable_nat ? 1 : 0

  project = var.project_id
  name    = "${var.name}-router-${var.orchestration}"
  region  = var.subnet_region
  network = var.network
}

resource "google_compute_router_nat" "nat" {
  count = var.enable_nat ? 1 : 0

  project = var.project_id
  name                               = "${var.name}-router-nat-${var.orchestration}"
  router                             = google_compute_router.router[0].name
  region                             = google_compute_router.router[0].region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = var.subnetwork_id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}