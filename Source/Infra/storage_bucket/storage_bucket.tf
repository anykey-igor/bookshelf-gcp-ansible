#---------------------------------------------------
# Create storage bucket
#---------------------------------------------------
resource "google_storage_bucket" "storage_bucket" {
  count = var.enable_storage_bucket ? 1 : 0

  name     = "${lower(var.bucket_name)}-${lower(var.bucket_prefix)}-${lower(var.orchestration)}"
  project  = var.project
  location = var.location

  public_access_prevention    = var.public_access_prevention #"enforced"
  uniform_bucket_level_access = true
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [var.retention_policy]
    content {
      is_locked        = var.retention_policy.is_locked
      retention_period = var.retention_policy.retention_period
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                        = lookup(lifecycle_rule.value.condition, "age", null)
        created_before             = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state                 = lookup(lifecycle_rule.value.condition, "with_state", lookup(lifecycle_rule.value.condition, "is_live", false) ? "LIVE" : null)
        matches_storage_class      = lookup(lifecycle_rule.value.condition, "matches_storage_class", null)
        matches_prefix             = lookup(lifecycle_rule.value.condition, "matches_prefix", null)
        matches_suffix             = lookup(lifecycle_rule.value.condition, "matches_suffix", null)
        num_newer_versions         = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        custom_time_before         = lookup(lifecycle_rule.value.condition, "custom_time_before", null)
        days_since_custom_time     = lookup(lifecycle_rule.value.condition, "days_since_custom_time", null)
        days_since_noncurrent_time = lookup(lifecycle_rule.value.condition, "days_since_noncurrent_time", null)
        noncurrent_time_before     = lookup(lifecycle_rule.value.condition, "noncurrent_time_before", null)
      }
    }
  }
  autoclass {
    enabled = false
  }
  versioning {
    enabled = var.versioning_enabled
  }
  logging {
    log_bucket        = var.logging_log_bucket
    log_object_prefix = var.logging_log_object_prefix
  }
  lifecycle {
    ignore_changes        = [labels, autoclass, id, name]
    create_before_destroy = false
  }
  timeouts {
    create = "4m"
    update = "4m"
    read   = "4m"
  }

}

resource "google_storage_bucket_iam_member" "bucket_member" {
  count  = var.enable_storage_bucket && var.enable_access_alluser ? 1 : 0
  bucket = google_storage_bucket.storage_bucket[count.index].name
  member = "allUsers"
  role   = "roles/storage.objectViewer"
}