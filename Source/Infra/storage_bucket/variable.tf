#---------------------------------------------------------------------------------------------------------------------
# General Variables
#---------------------------------------------------------------------------------------------------------------------
variable "enable_storage_bucket" {
  description = "Enable storage bucket usage"
  default     = "true"
}
variable "enable_access_alluser" {
  description = "Enable storage bucket usage"
  default     = "false"
}
variable "project" {
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type    = string
  default = ""
}
variable "bucket_name" {
  description = "(Required) The name of the bucket."
  type    = string
  default = ""
}
variable "bucket_prefix" {
  description = "(Optional) The prefix of the bucket name."
  type    = string
}
variable "orchestration" {
  description = "Type of orchestration"
  type    = string
  default = "tf"
}
variable "environment" {
  description = "Environment for service"
  type    = string
  default = "DEMO"
}
variable "location" {
  description = "(Optional, Default: 'US')"
  default     = "EU"
}
variable "region" {
  type    = string
  default = ""
}
variable "storage_class" {
  type        = string
  default     = "STANDARD"
  description = "The Storage Class of the new bucket. Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`."
  validation {
    condition     = contains(["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`."
  }
}
variable "force_destroy" {
  description = "(Optional, Default: false) When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
  default     = false
}
variable "autoclass" {
  description = "(Optional) The bucket's Autoclass configuration."
  default = false
}
variable "public_access_prevention" {
  description = "(Optional) Prevents public access to a bucket. Acceptable values are 'inherited' or 'enforced'. If 'inherited', the bucket uses public access prevention. only if the bucket is subject to the public access prevention organization policy constraint. Defaults to 'inherited'."
  type = string
  default = "enforced"
}

variable "lifecycle_rules" {
  type = set(object({
    action    = any
    condition = any
  }))
  default     = []
  description = <<-DOC
    The list of bucket Lifecycle Rules.
      action:
        type:
          The type of the action of this Lifecycle Rule.
          Supported values include: Delete, SetStorageClass and AbortIncompleteMultipartUpload.
        storage_class:
          (Required if action type is SetStorageClass)
          The target Storage Class of objects affected by this Lifecycle Rule.
          Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`.
      condition:
        age:
          Minimum age of an object in days to satisfy this condition.
        created_before:
          Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.
        with_state:
          Match to live and/or archived objects. Unversioned buckets have only live objects.
          Allowed values: `LIVE`, `ARCHIVED`, `ANY`.
        matches_storage_class:
          Storage Class of objects to satisfy this condition.
          Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`.
        matches_prefix:
          (Optional) One or more matching name prefixes to satisfy this condition.
        matches_suffix:
          (Optional) One or more matching name suffixes to satisfy this condition.
        num_newer_versions:
          Relevant only for versioned objects.
          The number of newer versions of an object to satisfy this condition.
        custom_time_before:
          Creation date of an object in RFC 3339 (e.g. `2017-06-13`) to satisfy this condition.
        days_since_custom_time:
          Date in RFC 3339 (e.g. `2017-06-13`) when an object's Custom-Time metadata is earlier than the date specified in this condition.
        days_since_noncurrent_time:
          Relevant only for versioned objects.
          Number of days elapsed since the noncurrent timestamp of an object.
        noncurrent_time_before:
          Relevant only for versioned objects.
          The date in RFC 3339 (e.g. `2017-06-13`) when the object became nonconcurrent.
  DOC
}
variable "retention_policy" {
  type = object({
    is_locked        = bool
    retention_period = number
  })
  default     = null
  description = <<-DOC
    Configuration of the bucket's data retention policy for how long objects in the bucket should be retained.
      is_locked:
        If set to `true`, the bucket will be locked and permanently restrict edits to the bucket's retention policy.
      retention_period:
        The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived.
  DOC
}
variable "uniform_bucket_level_access" {
  description = ""
  type = bool
  default = true
}
variable "default_kms_key_name" {
  type        = string
  default     = null
  description = "The `id` of a Cloud KMS key that will be used to encrypt objects inserted into this bucket, if no encryption method is specified."
}

variable "versioning_enabled" {
  description = "(Optional) While set to true, versioning is fully enabled for this bucket."
  default     = "false"
}
variable "logging_log_bucket" {
  description = "(Required) The bucket that will receive log objects."
  default     = ""
}
variable "logging_log_object_prefix" {
  description = "(Optional, Computed) The object prefix for log objects. If it's not provided, by default GCS sets this to the log_bucket's name."
  default     = ""
}