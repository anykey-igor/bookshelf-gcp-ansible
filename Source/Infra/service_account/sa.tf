locals {
  gr_roless  = flatten([for i in var.gr_roles : i.roles])
  group_name = flatten(var.gr_roles[*].gr_name)
  sa_roless  = flatten([for i in var.sa_roles : i.roles])
  gr_name    = flatten(var.sa_roles[*].sa_name)
}

resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = "bookshelf-sa"
  display_name = "bookshelf-sa"
  description  = "Bookshelf APP Service Account"
}
resource "google_project_iam_member" "iam_sa" {
  count   = length(local.sa_roless)
  project = var.project_id
  role    = element(local.sa_roless, count.index)
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
resource "google_project_iam_member" "iam_member" {
  count   = length(local.gr_roless)
  project = var.project_id
  role    = element(local.gr_roless, count.index)
  member  = "group:${local.group_name[0]}"
}
