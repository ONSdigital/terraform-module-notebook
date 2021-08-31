variable "name" {
  type        = string
  description = "The name of the notebook instance"
}

variable "project" {
  type        = string
  default     = ""
  description = "Optional: The GCP project to deploy the notebook instance into"
}

variable "zone" {
  type        = string
  default     = "europe-west2"
  description = "Optional: The GCP zone to the deploy the note book instance into"
}

variable "machine_type" {
  type        = string
  default     = "n1-standard-1"
  description = "Optional: The machine type of the notebook instance. For other options, see: https://cloud.google.com/compute/docs/machine-types"
}

variable "vm_image_project" {
  type        = string
  default     = "deeplearning-platform-release"
  description = "Optional: The name of the Google Cloud project that this VM image belongs to. Format: projects/{project_id}"
}

variable "vm_image_image_family" {
  type        = string
  default     = "pytorch-latest-cpu"
  description = "Optional: Use this VM image family to find the image; the newest image in this family will be used. See: https://cloud.google.com/ai-platform/deep-learning-vm/docs/images"
}

variable "service_account_email" {
  type        = string
  default     = ""
  description = "Optional: The service account email to run the notebook instance as"
}

variable "install_gpu_driver" {
  type        = bool
  default     = false
  description = "Optional: Whether or not to install the GPU driver"
}

variable "boot_disk_type" {
  type        = string
  default     = "PD_STANDARD"
  description = "Optional: Boot disk type for notebook instance"
}

variable "boot_disk_size_gb" {
  type        = number
  default     = 50
  description = "Optional: Size in GB of boot disk"
}

variable "data_disk_type" {
  type        = string
  default     = "DISK_TYPE_UNSPECIFIED"
  description = "Optional: Boot disk type"
}

variable "data_disk_size_gb" {
  type        = number
  default     = 1
  description = "Optional:  The size in GB of the non-boot disk"
}

variable "notebook_network_name" {
  type        = string
  default     = "notebook-vpc"
  description = "Optional: The name of the VPC to deploy this instance is in"
}

variable "notebook_sub_network_self_link" {
  type        = string
  default     = ""
  description = "Optional: The name of the subnet to deploy this instance is in"
}

variable "accelerator_config_type" {
  type        = string
  default     = "NVIDIA_TESLA_T4"
  description = "Type of accelerator. For values see: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_instance#type"
}

variable "accelerator_config_core_count" {
  type        = number
  default     = 1
  description = "The number of cores for this accelerator"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Optional: Additional labels for the notebook"
}

variable "git_config" {
  type        = map(string)
  description = "Required: The notebook user's name and email address to set name and email in git config"
}

variable "startup_script_path" {
  type        = string
  default     = "default.sh"
  description = "Optional: Specify the path of a custom startup script"
}

variable "role_id" {
  type        = string
  default     = ""
  description = "Optional: The role to assign to the notebook service account. Requires `service_account_email` to be specified"
}

variable "enable_gpu" {
  type        = bool
  default     = false
  description = "Optional: If set to true then the notebook will include a GPU"
}

variable "retain_disk" {
  type        = bool
  default     = false
  description = "Optional: If set to true the data disk will be retained when the notebook is deleted."
}
