output "service_account_name" {
  value = google_service_account.service_account.name
}
output "service_account_display_name" {
  value = google_service_account.service_account.display_name
}
output "service_account_id" {
  value = google_service_account.service_account.account_id
}
output "service_account_email" {
  value = google_service_account.service_account.email
}