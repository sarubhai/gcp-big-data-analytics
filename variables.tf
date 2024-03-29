# variables.tf
# Owner: Saurav Mitra
# Description: Variables used by terraform config to create the infrastructure resources for GCP Big Data Analytics
# https://www.terraform.io/docs/configuration/variables.html

# Tags
variable "prefix" {
  description = "This prefix will be included in the name of the resources."
  default     = "gcp-bda"
}

variable "owner" {
  description = "This owner name tag will be included in the owner of the resources."
  default     = "saurav-mitra"
}

# Google VPC
variable "google_application_credentials" {
  description = "Google Application Credentials Json."
  default     = "crendentials-json-content"
}

variable "project_id" {
  description = "The Project ID."
}

variable "region" {
  description = "The GCP Region."
  default     = "asia-southeast1"
}

variable "zone" {
  description = "The GCP Zone."
  default     = "asia-southeast1-a"
}

variable "private_subnets" {
  description = "A list of CIDR blocks to use for the private subnet."
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "A list of CIDR blocks to use for the public subnet."
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

# VM
variable "ssh_user" {
  description = "The SSH Username."
  default     = "gcpadmin"
}

variable "ssh_public_key" {
  description = "The SSH Public Key."
}

# Dataproc
variable "master_machine_type" {
  description = "The Master Nodes Machine Type"
  default     = "e2-standard-2"
}

variable "master_num_instances" {
  description = "The Master Nodes Count"
  default     = 1
}

variable "master_boot_disk_type" {
  description = "The Master Nodes Boot Disk Type"
  default     = "pd-standard"
}

variable "master_boot_disk_size_gb" {
  description = "The Master Nodes Boot Disk Size in GB"
  default     = 100
}

variable "worker_machine_type" {
  description = "The Worker Nodes Machine Type"
  default     = "e2-standard-2"
}

variable "worker_num_instances" {
  description = "The Worker Nodes Count"
  default     = 2
}

variable "worker_boot_disk_type" {
  description = "The Worker Nodes Boot Disk Type"
  default     = "pd-standard"
}

variable "worker_boot_disk_size_gb" {
  description = "The Worker Nodes Boot Disk Size in GB"
  default     = 100
}

variable "dataproc_version" {
  description = "The Dataproc Version"
  default     = "2.0-debian10"
}

variable "dataproc_optional_components" {
  description = "The Dataproc Optional Components"
  default     = ["HIVE_WEBHCAT", "PRESTO", "JUPYTER", "ZEPPELIN"]
}
