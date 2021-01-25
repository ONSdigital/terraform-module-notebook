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
| accelerator\_config\_core\_count | The number of cores for this accelerator | `number` | `0` | no |
| accelerator\_config\_type | Type of accelerator. For values see: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_instance#type | `string` | `""` | no |
| boot\_disk\_size\_gb | Optional: Size in GB of boot disk | `number` | `50` | no |
| boot\_disk\_type | Optional: Boot disk type for notebook instance | `string` | `"PD_STANDARD"` | no |
| data\_disk\_size\_gb | Optional:  The size in GB of the non-boot disk | `number` | `1` | no |
| data\_disk\_type | Optional: Boot disk type | `string` | `"DISK_TYPE_UNSPECIFIED"` | no |
| git\_config | Required: The notebook user's name and email address to set name and email in git config | `map(string)` | n/a | yes |
| install\_gpu\_driver | Optional: Whether or not to install the GPU driver | `bool` | `true` | no |
| labels | Optional: Additional labels for the notebook | `map` | `{}` | no |
| machine\_type | Optional: The machine type of the notebook instance. For other options, see: https://cloud.google.com/compute/docs/machine-types | `string` | `"n1-standard-1"` | no |
| name | The name of the notebook instance | `string` | n/a | yes |
| notebook\_network | Optional: The name of the VPC to deploy this instance is in | `string` | `"notebook-vpc"` | no |
| notebook\_sub\_network | Optional: The name of the subnet to deploy this instance is in | `string` | `""` | no |
| project | Optional: The GCP project to deploy the notebook instance into | `string` | `""` | no |
| service\_account | Optional: A service account within the same project to run the instance as | `string` | `""` | no |
| vm\_image\_image\_family | Optional: Use this VM image family to find the image; the newest image in this family will be used. See: [Notebook Images](https://cloud.google.com/ai-platform/deep-learning-vm/docs/images) | `string` | `"pytorch-latest-cpu"` | no |
| vm\_image\_project | Optional: The name of the Google Cloud project that this VM image belongs to. Format: projects/{project\_id} | `string` | `"deeplearning-platform-release"` | no |
| zone | Optional: The GCP zone to the deploy the note book instance into | `string` | `""` | no |


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


```shell
terraform init
terraform plan
terraform apply
```

TODO: Integrate map of image_families
