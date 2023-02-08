output "google_storage_bucket_name" {
  description = "Name of google storage bucket"
  value       = google_storage_bucket.storage_bucket.*.name
}
output "google_storage_bucket_self_link" {
  description = "self_link"
  value       = google_storage_bucket.storage_bucket.*.self_link
}
output "google_storage_bucket_url" {
  description = "URL"
  value       = google_storage_bucket.storage_bucket.*.url
}