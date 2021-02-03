data "google_project" "notebook_project" {}

data "google_compute_zones" "notebook_zone" {}

data "google_compute_network" "notebook_network" {
  name = var.notebook_network_name
}
