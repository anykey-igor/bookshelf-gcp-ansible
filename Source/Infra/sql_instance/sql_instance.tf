locals {
  users = { for u in var.additional_users : u.name => u }
}


resource "google_sql_database_instance" "sql_instance" {

  count = var.enable_sql_instance ? 1 : 0

  project             = var.project
  name                = "${lower(var.name)}-${lower(var.db_prefix)}-${lower(var.orchestration)}-${random_id.db_name_suffix.hex}"
  region              = var.region
  database_version    = var.db_version
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_id
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "default" {
  count      = var.enable_sql_instance && var.enable_default_db ? 1 : 0
  name       = var.db_name
  project    = var.project
  instance   = google_sql_database_instance.sql_instance.0.name #
  charset    = var.db_charset
  collation  = var.db_collation
  depends_on = [google_sql_database_instance.sql_instance]
}
##
resource "random_password" "user-password" {
  keepers = {
    name = google_sql_database_instance.sql_instance.0.name
  }
  length     = 32
  special    = false
  depends_on = [google_sql_database_instance.sql_instance]
}

resource "google_sql_user" "default" {
  count      = var.enable_default_user ? 1 : 0
  name       = var.user_name
  project    = var.project
  instance   = google_sql_database_instance.sql_instance.0.name
  host       = var.user_host
  password   = var.user_password == "" ? random_password.user-password.result : var.user_password
  depends_on = [google_sql_database_instance.sql_instance]
}

resource "random_password" "additional_passwords" {
  for_each = local.users
  keepers = {
    name = google_sql_database_instance.sql_instance.0.name
  }

  length     = 32
  special    = false
  depends_on = [google_sql_database_instance.sql_instance]
}
resource "google_sql_user" "additional_users" {
  for_each = local.users

  project    = var.project
  name       = each.value.name
  password   = lookup(each.value, "password", random_password.additional_passwords[each.key].result)
  host       = lookup(each.value, "host", var.user_host)
  instance   = google_sql_database_instance.sql_instance.0.name
  type       = lookup(each.value, "type", "BUILT_IN")
  depends_on = [google_sql_database_instance.sql_instance]
}

resource "google_compute_global_address" "private_ip_address" {
  project       = var.project
  name          = "private-ip-pool-sql"
  description   = var.description_sql
  purpose       = "VPC_PEERING"
  address       = var.address_subnet
  address_type  = "INTERNAL"
  ip_version    = var.ip_version
  prefix_length = 24
  network       = var.network_self_link
  depends_on    = [var.network]
}
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
resource "random_id" "db_name_suffix" {
  byte_length = 4
}