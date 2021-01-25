resource "google_storage_bucket_iam_binding" "notebook_gcs_binding" {
  role   = "roles/storage.admin"
  bucket = google_storage_bucket.notebook_bucket[0].name

  members = [
    "serviceAccount:${local.compute_engine_service_account}"
  ]
}
