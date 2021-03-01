locals {
  r_image_family                 = "r-3-6-cpu-experimental"
  compute_engine_service_account = "${data.google_project.notebook_project.number}-compute@developer.gserviceaccount.com"
  post_startup_script_url        = "${google_storage_bucket.notebook_bucket.url}/${google_storage_bucket_object.notebook_instance_post_startup_script.output_name}"
  required_labels = {
    shutdown = "true"
  }
}

resource "google_notebooks_instance" "notebook_instance_vm" {
  provider = google-beta

  name         = var.name
  location     = "${var.zone}-a"
  machine_type = var.machine_type

  vm_image {
    project      = var.vm_image_project
    image_family = var.vm_image_image_family
  }

  dynamic "accelerator_config" {
    for_each = var.enable_gpu ? [1] : []
    content {
      core_count = var.accelerator_config_core_count
      type       = var.accelerator_config_type
    }
  }

  service_account = length(var.service_account_email) > 0 ? var.service_account_email : local.compute_engine_service_account

  install_gpu_driver = var.enable_gpu

  boot_disk_type    = var.boot_disk_type
  boot_disk_size_gb = var.boot_disk_size_gb
  data_disk_type    = var.data_disk_type
  data_disk_size_gb = var.data_disk_size_gb

  no_public_ip    = false
  no_proxy_access = false

  network = data.google_compute_network.notebook_network.self_link
  subnet  = length(var.notebook_sub_network_self_link) > 0 ? var.notebook_sub_network_self_link : element(data.google_compute_network.notebook_network.subnetworks_self_links, 0)

  post_startup_script = local.post_startup_script_url

  labels = merge(local.required_labels, var.labels)

  metadata = {
    terraform  = "true"
    proxy-mode = "service_account"
  }
}

