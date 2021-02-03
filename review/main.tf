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

module "davids_review_notebook" {
  source                         = "../"
  name                           = "davids-review-notebook"
  notebook_network_name          = google_compute_network.network.name
  notebook_sub_network_self_link = google_compute_subnetwork.subnet.self_link

  git_config = {
    email = "david.pugh@ons.gov.uk",
    name  = "David Pugh"
  }
}

module "dans_review_notebook" {
  source                         = "../"
  name                           = "dans-review-notebook"
  vm_image_image_family          = "r-3-6-cpu-experimental"
  notebook_network_name          = google_compute_network.network.name
  notebook_sub_network_self_link = google_compute_subnetwork.subnet.self_link

  git_config = {
    email = "dan.melluish@ons.gov.uk",
    name  = "Dan Melluish"
  }
}

