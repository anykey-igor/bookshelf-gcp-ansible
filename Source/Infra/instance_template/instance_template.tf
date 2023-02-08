resource "google_compute_health_check" "bookshelf_healthcheck" {
  project             = var.project_id
  name                = "${var.name}-health-check-${var.orchestration}"
  check_interval_sec  = 30
  timeout_sec         = 20
  healthy_threshold   = 2
  unhealthy_threshold = 10

  http_health_check {
    request_path = "/_ah/health"
    port         = "8080"
  }
}


resource "google_compute_instance_template" "bookshelf_it" {
  project              = var.project_id
  machine_type         = var.machine_type
  name                 = "${var.name}-instance-template-${var.orchestration}"
  region               = var.region
  instance_description = "description assigned to instances"

  tags = var.network_tags
  disk {
    source_image = "debian-10-buster-v20221206"
    auto_delete  = true
    boot         = true
  }

  metadata = {
    PROJECT_ID = var.project_id
    MYSQL_URL  = join(",", var.mysql_url)
    MYSQL_DB   = join(",", var.mysql_db)
    MYSQL_USER = var.name
    MYSQL_PASS = var.user_pass
    BUCKET_URL = join(",", var.bucket_url)
  }
  metadata_startup_script = file("${var.startup_script}")

  service_account {
    email  = var.email_sa
    scopes = ["userinfo-email","cloud-platform"]
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
  }

}


resource "google_compute_region_instance_group_manager" "instance_group_manager" {
  project            = var.project_id
  region             = var.region
  name               = "${var.name}-mig-${var.orchestration}"
  base_instance_name = "instance-group-manager"
  target_size        = "1"

  named_port {
    name = "http"
    port = 8080
  }
  version {
    instance_template = google_compute_instance_template.bookshelf_it.id
  }
  lifecycle {
    ignore_changes = [
      #"network_interface",
    ]
    create_before_destroy = true
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.bookshelf_healthcheck.id
    initial_delay_sec = 180
  }
  depends_on = [google_compute_instance_template.bookshelf_it]
}


resource "google_compute_region_autoscaler" "autoscaler" {
  project = var.project_id
  name    = "my-region-autoscaler"
  region  = var.region
  target  = google_compute_region_instance_group_manager.instance_group_manager.self_link

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.9
    }
  }
}