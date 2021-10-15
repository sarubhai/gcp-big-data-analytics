# variables.tf
# Owner: Saurav Mitra
# Description: Variables used by terraform config to create Big Query Resources

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

variable "zone" {
  description = "The GCP Zone."
}

variable "vpc_name" {
  description = "The VPC Name."
}

variable "private_subnet_name" {
  description = "The private subnets Name."
}

variable "public_subnet_name" {
  description = "The public subnets Name."
}

variable "cs_datagen_bucket_name" {
  description = "The Cloud Storage Bucket Name for Generated Datasets."
}

variable "cs_resultset_bucket_name" {
  description = "The Cloud Storage Bucket Name for Resultset Datasets."
}

variable "master_machine_type" {
  description = "The Master Nodes Machine Type"
}

variable "master_num_instances" {
  description = "The Master Nodes Count"
}

variable "master_boot_disk_type" {
  description = "The Master Nodes Boot Disk Type"
}

variable "master_boot_disk_size_gb" {
  description = "The Master Nodes Boot Disk Size in GB"
}

variable "worker_machine_type" {
  description = "The Worker Nodes Machine Type"
}

variable "worker_num_instances" {
  description = "The Worker Nodes Count"
}

variable "worker_boot_disk_type" {
  description = "The Worker Nodes Boot Disk Type"
}

variable "worker_boot_disk_size_gb" {
  description = "The Worker Nodes Boot Disk Size in GB"
}

variable "dataproc_version" {
  description = "The Dataproc Version"
}

variable "dataproc_optional_components" {
  description = "The Dataproc Optional Components"
}
