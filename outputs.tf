output "notebook_name" {
  value = google_notebooks_instance.notebook_instance_vm.name
}

output "notebook_id" {
  value = google_notebooks_instance.notebook_instance_vm.id
}

output "notebook_endpoint" {
  value = google_notebooks_instance.notebook_instance_vm.proxy_uri
}

output "notebook_labels" {
  value = google_notebooks_instance.notebook_instance_vm.labels
}
