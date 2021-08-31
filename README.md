# Notebook

provision a GCP Cloud AI notebook instance

## Version
See: [Changelog](./CHANGELOG.md)

## Requirements

[Terraform 14](https://www.terraform.io/downloads.html)

## Providers

| Name | Version |
|------|---------|
| google | `3.51.0` |
| google-beta | `3.51.0` |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| accelerator\_config\_core\_count | The number of cores for this accelerator | `number` | `1` | no |
| accelerator\_config\_type | Type of accelerator. For values see: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_instance#type | `string` | `"NVIDIA_TESLA_T4"` | no |
| boot\_disk\_size\_gb | Optional: Size in GB of boot disk | `number` | `50` | no |
| boot\_disk\_type | Optional: Boot disk type for notebook instance | `string` | `"PD_STANDARD"` | no |
| data\_disk\_size\_gb | Optional:  The size in GB of the non-boot disk | `number` | `1` | no |
| data\_disk\_type | Optional: Boot disk type | `string` | `"DISK_TYPE_UNSPECIFIED"` | no |
| enable\_gpu | Optional: Whether or not to enable GPU | `bool` | `false` | no  |
| git\_config | Required: The notebook user's name and email address to set name and email in git config | `map(string)` | n/a | yes |
| install\_gpu\_driver | Optional: Whether or not to install the GPU driver | `bool` | `false` | no |
| labels | Optional: Additional labels for the notebook | `map` | `{}` | no |
| machine\_type | Optional: The machine type of the notebook instance. For other options, see: https://cloud.google.com/compute/docs/machine-types | `string` | `"n1-standard-1"` | no |
| name | The name of the notebook instance | `string` | n/a | yes |
| notebook\_network\_name | Optional: The name of the VPC to deploy this instance is in | `string` | `"notebook-vpc"` | no |
| notebook\_sub\_network\_self\_link | Optional: The name of the subnet to deploy this instance is in | `string` | `""` | no |
| project | Optional: The GCP project to deploy the notebook instance into | `string` | `""` | no |
| service\_account | Optional: A service account within the same project to run the instance as | `string` | `""` | no |
| role\_id | Optional: The role to assign to the notebook service account. **Note** Requires `service_account_email` to be specified | `string` | `""` | no |
| service\_account\_email | Optional: The service account email to run the notebook instance as | `string` | `""` | no |
| startup\_script\_path | Optional: Specify the path of a custom startup script | `string` | n/a | no |
| vm\_image\_image\_family | Optional: Use this VM image family to find the image; the newest image in this family will be used. See: [Notebook Images](https://cloud.google.com/ai-platform/deep-learning-vm/docs/images) | `string` | `"pytorch-latest-cpu"` | no |
| vm\_image\_project | Optional: The name of the Google Cloud project that this VM image belongs to. Format: projects/{project\_id} | `string` | `"deeplearning-platform-release"` | no |
| zone | Optional: The GCP zone to the deploy the note book instance into | `string` | `"europe-west2"` | no |
| retain_disk | Optional: If set to true the data disk for the notebook will be retained after deletion | `boolean` | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| notebook\_endpoint | The proxy endpoint that is used to access the notebook |
| notebook\_id | An identifier for the notebook |
| notebook\_labels | A list of labels for the notebook |
| notebook\_name | Display name for the notebook |


## Usage

Python notebook (default)

```terraform
module "davids_pytorch_notebook" {
  source = "github.com/ONSdigital/terraform-module-notebook"
  name   = "davids-py-notebook"
  
  git_config = {
    email = "david.pugh@ons.gov.uk",
    name  = "David Pugh"
  }
}
```

R configured notebook

```terraform
module "dans_r_notebook" {
  source = "github.com/ONSdigital/terraform-module-notebook"
  name   = "dans-r-notebook"
  vm_image_image_family = "r-3-6-cpu-experimental"
  
  git_config = {
    email = "dan.melluish@ons.gov.uk",
    name  = "Dan Melluish"
  }
}
```

Notebook with service account and role assigned to the notebook instance

```terraform
module "service_account_1_notebook" {
  source                         = "github.com/ONSdigital/terraform-module-notebook"
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
```

**Note**
Terraform may complain about the role id not being computed at the time of apply. In which case you will need to deploy 
The custom role first before the notebook using the role

```shell
terraform init
terraform plan
terraform apply
```

## Contributing 

__To Review__

1. Checkout feature branch
2. Enter your project name [here](review/main.tf#L2) and your state bucket name [here](review/main.tf#L19)
2. `cd review && terraform init`
2. Run terraform i.e `terraform <plan/apply>`
3. Head over to the [Notebook console](https://console.cloud.google.com/ai/platform/notebooks/list/instances) and open __JUPYTER_LAB__ on your notebook
4. Check changes related to feature
5. Clear up; `terraform destroy` and `git checkout review/main.tf`

---
TODO: Integrate map of image_families
