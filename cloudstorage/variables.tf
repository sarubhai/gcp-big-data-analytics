# variables.tf
# Owner: Saurav Mitra
# Description: Variables used by terraform config to create Cloud Storage Buckets

variable "prefix" {
  description = "This prefix will be included in the name of the resources."
}

variable "owner" {
  description = "This owner name tag will be included in the owner of the resources."
}

variable "project_id" {
  description = "The Project ID."
}

variable "region" {
  description = "The GCP Region."
}
