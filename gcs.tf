resource "google_storage_bucket" "notebook_bucket" {
  count = var.vm_image_image_family == local.r_image_family ? 1 : 0

  name          = "notebook-${var.name}"
  location      = "EUROPE-WEST2"
  force_destroy = true

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
  count = var.vm_image_image_family == local.r_image_family ? 1 : 0

  bucket  = google_storage_bucket.notebook_bucket[0].name
  name    = "init.sh"
  content = var.vm_image_image_family == local.r_image_family ? templatefile("${path.module}/assets/r-notebook.sh", var.git_config) : templatefile("${path.module}/assets/py-notebook.sh", var.git_config)
}
