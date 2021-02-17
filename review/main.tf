variable "project" {
  default = "<YOUR PROJECT NAME HERE>"
}

provider "google" {
  project = var.project
  region  = "europe-west2"
  zone    = "europe-west2-a"
}

provider "google-beta" {
  project = var.project
  region  = "europe-west2"
  zone    = "europe-west2-a"
}

terraform {
  backend "gcs" {
    bucket = "<YOUR STATE BUCKET NAME HERE>"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.51.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "3.51.0"
    }

  }
}

resource "google_compute_network" "network" {
  name                    = "dsc-review-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "dsc-review-subnet"
  ip_cidr_range = "10.2.0.0/24"
  network       = google_compute_network.network.id
  region        = "europe-west2"
}

resource "google_project_iam_custom_role" "notebook_user_role" {
  role_id     = "notebookUserRole"
  title       = "notebook-user-role"
  description = "Role to allow AI Notebook user access"
  permissions = [
    "iam.serviceAccounts.actAs",
    "compute.acceleratorTypes.list",
    "compute.diskTypes.list",
    "compute.instances.list",
    "compute.machineTypes.list",
    "compute.subnetworks.list",
    "compute.instances.start",
    "compute.instances.stop",
    "notebooks.environments.get",
    "notebooks.environments.getIamPolicy",
    "notebooks.environments.list",
    "notebooks.instances.get",
    "notebooks.instances.getIamPolicy",
    "notebooks.instances.list",
    "notebooks.locations.get",
    "notebooks.locations.list",
    "notebooks.operations.get",
    "notebooks.operations.list",
    "notebooks.instances.update",
    "notebooks.instances.start",
    "notebooks.instances.stop"
  ]
}

resource "google_service_account" "service_account_1" {
  account_id   = "service-account-1"
  display_name = "service-account-1"
}

resource "google_service_account" "service_account_2" {
  account_id   = "service-account-2"
  display_name = "service-account-2"
}

//resource "google_service_account_iam_member" "service_account_1_binding" {
//  service_account_id = google_service_account.service_account_1.name
//  role               = "roles/iam.serviceAccountUser"
//  member             = "user:satya.bingumalla@ext.ons.gov.uk"
//}

resource "google_service_account_iam_member" "service_account_2_binding" {
  service_account_id = google_service_account.service_account_2.name
  role               = "roles/iam.serviceAccountUser"
  member             = "user:"
}

resource "google_storage_bucket" "bucket_1" {
  name = "project-${var.project}-bucket-1"

  location                    = "EUROPE-WEST2"
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket_2" {
  name = "project-${var.project}-bucket-2"

  location                    = "EUROPE-WEST2"
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "bucket_1_binding" {
  bucket = google_storage_bucket.bucket_1.name
  member = "serviceAccount:${google_service_account.service_account_1.email}"
  role   = "roles/storage.objectCreator"
}

resource "google_storage_bucket_iam_member" "bucket_2_binding" {
  bucket = google_storage_bucket.bucket_2.name
  member = "serviceAccount:${google_service_account.service_account_2.email}"
  role   = "roles/storage.objectCreator"
}

module "service_account_1_notebook" {
  source                         = "../"
  name                           = "service-account-1-review-notebook"
  notebook_network_name          = google_compute_network.network.name
  notebook_sub_network_self_link = google_compute_subnetwork.subnet.self_link
  service_account_email          = google_service_account.service_account_1.email
  role_id                        = google_project_iam_custom_role.notebook_user_role.id

  git_config = {
    email = "service.account1@ons.gov.uk",
    name  = "service account1"
  }
}

module "service_account_2_notebook" {
  source                         = "../"
  name                           = "service-account-2-review-notebook"
  vm_image_image_family          = "r-3-6-cpu-experimental"
  notebook_network_name          = google_compute_network.network.name
  notebook_sub_network_self_link = google_compute_subnetwork.subnet.self_link
  service_account_email          = google_service_account.service_account_2.email
  role_id                        = google_project_iam_custom_role.notebook_user_role.id

  git_config = {
    email = "service.account2@ons.gov.uk",
    name  = "service account2"
  }
}
