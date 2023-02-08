output "instance_name" {
  value       = [for i in google_sql_database_instance.sql_instance : i.name]
  description = "The instance name for the master instance"
}
output "instance_ip_address" {
  value       = [for i in google_sql_database_instance.sql_instance : i.ip_address]
  description = "The IPv4 address assigned for the master instance"
}
output "private_address" {
  value       = [for i in google_sql_database_instance.sql_instance : i.private_ip_address]
  description = "The private IP address assigned for the master instance"
}
output "instance_first_ip_address" {
  value       = [for i in google_sql_database_instance.sql_instance : i.first_ip_address]
  description = "The first IPv4 address of the addresses assigned for the master instance."
}
output "instance_connection_name" {

  value       = [for i in google_sql_database_instance.sql_instance : i.connection_name]
  description = "The connection name of the master instance to be used in connection strings"
}
output "instance_self_link" {
  value       = [for i in google_sql_database_instance.sql_instance : i.self_link]
  description = "The URI of the master instance"
}
output "instance_server_ca_cert" {
  value       = google_sql_database_instance.sql_instance.*.server_ca_cert
  description = "The CA certificate information used to connect to the SQL instance via SSL"
}
#
output "instance_service_account_email_address" {
  value       = [for i in google_sql_database_instance.sql_instance : i.service_account_email_address]
  description = "The service account email address assigned to the master instance"
}
output "additional_users" {
  description = "List of maps of additional users and passwords"
  value = [for r in google_sql_user.additional_users :
    {
      name     = r.name
      password = r.password
    }
  ]
  sensitive = true
}
output "db_name" {
  value = google_sql_database.default.*.name
}