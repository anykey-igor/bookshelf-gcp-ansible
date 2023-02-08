resource "google_compute_firewall" "compute_firewall_all_ingress" {
  count = var.enable_all_ingress && upper(var.direction) == "INGRESS" ? 1 : 0

  name        = "${lower(var.name)}-fw-${lower(var.environment)}-${lower(var.direction)}"
  description = var.description_firewall

  project = var.project

  network = google_compute_network.vpc_network.0.id

  priority      = var.priority
  source_ranges = var.source_ranges
  target_tags   = var.target_tags
  direction     = var.direction

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "custom_firewall_ingress_rules" {

  count       = !var.enable_all_ingress && var.enable_custom_ingress_rules && length(var.ingres_rules) > 0 ? length(var.ingres_rules) : 0
  name        = "${lower(var.name)}-allow-${lower(var.rules[var.ingres_rules[count.index]][2])}-${lower(var.orchestration)}"
  description = var.rules[var.ingres_rules[count.index]][4]

  project = var.project

  network = google_compute_network.vpc_network.0.id

  priority = var.priority

  source_ranges = var.source_ranges
  source_tags   = var.source_tags
  target_tags   = [var.rules[var.ingres_rules[count.index]][3]]
  direction     = var.direction

  allow {
    protocol = var.rules[var.ingres_rules[count.index]][1]
    ports    = [var.rules[var.ingres_rules[count.index]][0]]
  }
}