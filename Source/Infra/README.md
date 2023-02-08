# phase_3

Credential:

export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/credential.json


Need add variables.tf
Replace all hardcode in main.tf
need add .tfvars

VPC
Subnetwork
Firewall - need modify firewall variable - Rules and Tag
SQL Instance
SQL DB
SQL User
Storage Bucket

Role for terraform-sa:
   Editor
   Compute Network Admin
   Source Repository Administrator

	
Compute Network Admin
Editor
Service Account Admin
Service Account Token Creator
Source Repository Administrator
Storage Admin
Storage Object Admin

roles/iam.serviceAccountUser  The Service Account User role


For terraform remote state
https://cloud.google.com/docs/terraform/resource-management/store-state
Make sure you have the necessary Cloud Storage permissions on your user account:
storage.buckets.create
storage.buckets.list
storage.objects.get
storage.objects.create
storage.objects.delete
storage.objects.update

roles/storage.legacyBucketOwner
roles/storage.legacyObjectOwner




need Enable API:

compute.googleapis.com                 Compute Engine API
sqladmin.googleapis.com                Cloud SQL Admin API 
sourcerepo.googleapis.com              Cloud Source Repositories API 
pubsub.googleapis.com                  Cloud Pub/Sub API
servicenetworking.googleapis.com       Service Networking API
cloudresourcemanager.googleapis.com    Cloud Resource Manager API (for Terraform)
iam.googleapis.com                     Identity and Access Management (IAM) API
storage.googleapis.com                 Cloud Storage API

by default enabled: 

bigquery.googleapis.com                BigQuery API
bigquerymigration.googleapis.com       BigQuery Migration API
bigquerystorage.googleapis.com         BigQuery Storage API
cloudapis.googleapis.com               Google Cloud APIs
clouddebugger.googleapis.com           Cloud Debugger API
cloudtrace.googleapis.com              Cloud Trace API
datastore.googleapis.com               Cloud Datastore API
logging.googleapis.com                 Cloud Logging API
monitoring.googleapis.com              Cloud Monitoring API
servicemanagement.googleapis.com       Service Management API
serviceusage.googleapis.com            Service Usage API
sql-component.googleapis.com           Cloud SQL
storage-api.googleapis.com             Google Cloud Storage JSON API
storage-component.googleapis.com       Cloud Storage



   