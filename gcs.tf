resource "google_storage_bucket" "notebook_bucket" {
  name                        = "notebook-${var.name}"
  location                    = upper(var.zone)
  force_destroy               = true
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 1
    }

    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
  }

  labels = {
    project = data.google_project.notebook_project.name
  }
}

resource "google_storage_bucket_object" "notebook_instance_post_startup_script" {
  bucket  = google_storage_bucket.notebook_bucket.name
  name    = "init.sh"
  content = var.vm_image_image_family == local.r_image_family ? templatefile("${path.module}/assets/r-notebook.sh", var.git_config) : templatefile("${path.module}/assets/py-notebook.sh", var.git_config)
}
