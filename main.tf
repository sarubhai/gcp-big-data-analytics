# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the infrastructure resources for GCP Big Data Analytics

# VPC & Subnets
module "vpc" {
  source          = "./vpc"
  prefix          = var.prefix
  owner           = var.owner
  project_id      = var.project_id
  region          = var.region
  zone            = var.zone
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# Cloud Storage
module "cloudstorage" {
  source     = "./cloudstorage"
  prefix     = var.prefix
  owner      = var.owner
  project_id = var.project_id
  region     = var.region
}

# BigQuery
module "bigquery" {
  source                 = "./bigquery"
  prefix                 = var.prefix
  owner                  = var.owner
  project_id             = var.project_id
  region                 = var.region
  cs_datagen_bucket_name = module.cloudstorage.cs_datagen_bucket_name
  depends_on = [
    module.cloudstorage.google_storage_bucket_object
  ]
}

# Dataproc
module "dataproc" {
  source                       = "./dataproc"
  prefix                       = var.prefix
  owner                        = var.owner
  project_id                   = var.project_id
  region                       = var.region
  zone                         = var.zone
  vpc_name                     = module.vpc.vpc_name
  private_subnet_name          = module.vpc.private_subnet_name
  public_subnet_name           = module.vpc.public_subnet_name
  cs_datagen_bucket_name       = module.cloudstorage.cs_datagen_bucket_name
  cs_resultset_bucket_name     = module.cloudstorage.cs_resultset_bucket_name
  master_machine_type          = var.master_machine_type
  master_num_instances         = var.master_num_instances
  master_boot_disk_type        = var.master_boot_disk_type
  master_boot_disk_size_gb     = var.master_boot_disk_size_gb
  worker_machine_type          = var.worker_machine_type
  worker_num_instances         = var.worker_num_instances
  worker_boot_disk_type        = var.worker_boot_disk_type
  worker_boot_disk_size_gb     = var.worker_boot_disk_size_gb
  dataproc_version             = var.dataproc_version
  dataproc_optional_components = var.dataproc_optional_components

  depends_on = [
    module.cloudstorage.google_storage_bucket_object
  ]
}
