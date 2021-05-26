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

output "notebook_service_account_email" {
  value = length(var.service_account_email) > 0 ? var.service_account_email : google_service_account.generated_service_account.email
}