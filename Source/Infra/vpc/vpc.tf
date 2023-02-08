resource "google_compute_network" "vpc_network" {
  count = var.enable_vpc ? 1 : 0

  name        = "${lower(var.name)}-vpc-${lower(var.orchestration)}"
  description = var.description_vpc
  project     = var.project

  auto_create_subnetworks         = var.auto_create_subnetworks
  mtu                             = var.mtu_size
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create

  timeouts {
    create = "5m"
    update = "5m"
    delete = "5m"
  }
  lifecycle {
    ignore_changes        = []
    create_before_destroy = true
  }
}

resource "google_compute_subnetwork" "compute_subnetwork" {
  count = var.enable_subnetwork ? 1 : 0

  name          = "${lower(var.name)}-subnet-${lower(var.orchestration)}-${lower(var.region)}"
  description   = var.description_subnetwork
  project       = var.project
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.0.id

  private_ip_google_access = var.private_ip_google_access

  timeouts {
    create = "5m"
    update = "5m"
    delete = "5m"
  }

  lifecycle {
    ignore_changes        = []
    create_before_destroy = true
  }
}