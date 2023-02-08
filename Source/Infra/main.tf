module "vpc" {
  source = "./vpc/"
  # VPC
  enable_vpc                      = true
  project                         = var.project_id
  orchestration                   = var.orchestration
  region                          = var.gcp_region
  name                            = var.name
  vpc_of_name                     = var.vpc_name
  description_vpc                 = ""
  auto_create_subnetworks         = var.auto_create_subnet
  delete_default_routes_on_create = false
  routing_mode                    = "REGIONAL"
  mtu_size                        = 1460
  # Subnetwork
  enable_subnetwork        = true
  description_subnetwork   = ""
  ip_cidr_range            = var.ip_cidr_range
  private_ip_google_access = var.private_ip_access
  # Firewall
  enable_custom_ingress_rules = true
  enable_all_ingress          = false
  direction                   = "INGRESS"
  source_ranges               = var.ingres_source_range
  ingres_rules                = var.vpc_ingres_rules
}
module "sql_instance" {
  source = "./sql_instance/"

  project = var.project_id
  region  = var.gcp_region
  zone    = var.gcp_zone

  enable_sql_instance = true #need refactor sql_instance

  network           = module.vpc.google_compute_network_name[0]
  network_id        = module.vpc.google_compute_network_id[0]
  network_self_link = module.vpc.google_compute_network_self_link[0]

  name            = var.name
  description_sql = "Database server for bookshelf app"
  db_prefix       = "db"
  address_subnet  = "10.24.10.0"
  subnet_prefix   = "24"
  db_version      = "MYSQL_5_7"

  enable_default_db = true
  db_name           = var.name
  db_charset        = "utf8"
  db_collation      = "utf8_general_ci"

  enable_default_user = true
  user_host           = "localhost"
  additional_users = [
    {
      name     = "bookshelf"
      password = var.user_pass
      host     = "%"
      type     = "BUILT_IN"
    }
  ]
}
module "bookshelf_bucket" {
  source                   = "./storage_bucket/"

  enable_storage_bucket    = true
  enable_access_alluser    = true

  project                  = var.project_id
  force_destroy            = true
  location                 = var.gcp_region
  bucket_prefix            = var.bucket_prefix
  bucket_name              = var.bucket_name
  public_access_prevention = "inherited" # default: enforced
}

module "bookshelf_sa" {
  source     = "./service_account/"

  project_id = var.project_id

  sa_roles = [
    {
      sa_name        = "bookshelf-sa"
      type           = "serviceAccount"
      sa_description = "Bookshelf APP Service Account"
      roles = [
        "roles/source.reader",
        "roles/cloudsql.client",
        "roles/logging.logWriter",
        "roles/monitoring.metricWriter",
        "roles/pubsub.admin",
        "roles/storage.objectAdmin"
      ]
    }
  ]
  gr_roles = [
    {
      gr_name        = "gcp-experts@gcplabs.cloud"
      type           = "group"
      sa_description = "GCP Expert Group"
      roles = [
        "roles/viewer",
        "roles/resourcemanager.projectIamAdmin",
        "roles/source.reader"
      ]
    }
  ]
}
module "instance_template" {
  source          = "./instance_template/"

  project_id      = var.project_id
  name            = var.name

  network         = module.vpc.google_compute_network_name[0]
  subnetwork      = module.vpc.google_compute_subnetwork_self_link[0]
  subnetwork_name = module.vpc.google_compute_subnetwork_name[0]
  email_sa        = module.bookshelf_sa.service_account_email
  subnet_region   = module.vpc.subnet_region[0]
  subnetwork_id   = module.vpc.google_compute_subnetwork_id[0]

  network_tags    = ["ssh", "web-8080"]

  mysql_url       = module.sql_instance.instance_connection_name
  mysql_db        = module.sql_instance.db_name
  user_pass       = var.user_pass
  bucket_url      = module.bookshelf_bucket.google_storage_bucket_name
  startup_script  = "${path.module}/script/startup-script.sh"

  depends_on = [module.sql_instance]
}

module "bookshelf_nat" {
  source        = "./cloud_nat/"

  enable_nat    = true

  project_id    = var.project_id

  network       = module.vpc.google_compute_network_name[0]
  subnet_region = module.vpc.subnet_region[0]
  subnetwork_id = module.vpc.google_compute_subnetwork_id[0]
}
module "bookshelf-lb" {
  source = "./load_balancer/"

  project_id = var.project_id

  img_instance_group = module.instance_template.igm_instance_group
  health_check_id = module.instance_template.health_check_id
}