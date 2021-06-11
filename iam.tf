resource "google_storage_bucket_iam_binding" "notebook_gcs_binding" {
  role   = "roles/storage.admin"
  bucket = google_storage_bucket.notebook_bucket.name

  members = compact([
    "serviceAccount:${local.compute_engine_service_account}",
    length(var.service_account_email) > 0 ? "serviceAccount:${var.service_account_email}" : "",
    length(var.service_account_email) == 0 ? "serviceAccount:${google_service_account.generated_service_account[0].email}" : ""
  ])
}

resource "google_notebooks_instance_iam_member" "notebook_instance_service_account_binding" {
  count = length(var.role_id) > 0 ? 1 : 0

  project       = google_notebooks_instance.notebook_instance_vm.project
  location      = google_notebooks_instance.notebook_instance_vm.location
  instance_name = google_notebooks_instance.notebook_instance_vm.name
  role          = var.role_id
  member        = length(var.service_account_email) > 0 ? "serviceAccount:${var.service_account_email}" : "serviceAccount:${google_service_account.generated_service_account[0].email}"
}

resource "google_service_account" "generated_service_account" {
  count      = length(var.service_account_email) > 0 ? 0 : 1
  account_id = var.name
}