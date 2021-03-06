# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.1.7] - 2021-03-01
## Make GPU optional for new notebook [Jira Ticket](https://collaborate2.ons.gov.uk/jira/browse/CATDDSC-136)
- Added new __OPTIONAL__ variable (`enable_gpu`) to allow a notebook to be created with or without a GPU. 
- Default value for __OPTIONAL__ variable (`install_gpu_driver`) is now false.

## [0.1.6] - 2021-02-25
## Create Python PyTorch notebooks for EH team [Jira Ticket](https://collaborate2.ons.gov.uk/jira/browse/CATDDSC-101)
- Added new __OPTIONAL__ variable (`startup_script_path`) to allow a custom startup script to be specified

## [0.1.5] - 2021-02-16
## Notebook: Role Binding [Jira Ticket](https://collaborate2.ons.gov.uk/jira/browse/CATDDSC-84)
- Add a single binding for a service account to the created notebook instance and associated resources
- New var to pass role id to the binding
- Updated docs
- Changed `service_account` variable from `service_account` to `service_account_email`

## [0.1.4] - 2021-02-02
## Remove Unnecessary Logic [Jira Ticket](https://collaborate2.ons.gov.uk/jira/browse/CATDDSC-52)
- Removed unnecessary `count` expressions used for post startup script which is now executed regardless. ref **Notebook Git Config**
- Added `review/main.tf` for the purpose of reviewing changes to this module
- Assigned `var.zone` the default value `europe-west2`

## [0.1.3] - 2021-01-25
## Relocate Notebook Module [Jira Ticket](https://collaborate2.ons.gov.uk/jira/browse/CATDDSC-52)
- Amended docs to reflect change of source
- Updated Changelog

## [0.1.2] - 2021-01-19
## Notebook Git Config
- Add new __REQUIRED__ variable (`git_config`) to accept user's name and email to be passed to template scripts
- Added new shell script for non r notebooks to set git config
- Modified r package install script to set git config
- Modified GCS object resource to upload template shell script dependent on image family
- Added `CHANGELOG`
- Removed notebook instance resource from `notebooks.tf`
- Updated docs

## [0.1.1] - 2021-01-19
## Terraform GCP Notebook Module
- Updated docs
- Modified `post_startup_script` url
- Ran `terraform fmt`

## [0.1.0] - 2021-01-14
## Terraform GCP Notebook Module
- Initial Commit
